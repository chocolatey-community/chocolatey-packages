Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

. (Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -ChildPath 'data.ps1')
$packageName = $otherData.PackageName
$installerType = 'exe'
$silentArgs = '/quiet /norestart'
$validExitCodes = @(0, 3010)
$force = $Env:chocolateyPackageParameters -like '*Force*'

Write-Verbose 'Checking Service Pack requirements'
$os = Get-WmiObject -Class Win32_OperatingSystem
$version = [Version]$os.Version
if ($version -ge [Version]'6.1' -and $version -lt [Version]'6.2' -and $os.ServicePackMajorVersion -lt 1)
{
    # On Windows 7 / Server 2008 R2, Service Pack 1 is required.
    throw 'This package requires Service Pack 1 to be installed first. The "KB976932" package may be used to install it.'
}
elseif ($version -ge [Version]'6.0' -and $version -lt [Version]'6.1' -and $os.ServicePackMajorVersion -lt 2)
{
    # On Windows Vista / Server 2008, Service Pack 2 is required.
    throw 'This package requires Service Pack 2 to be installed first.'
}
elseif ($version -ge [Version]'5.2' -and $version -lt [Version]'6.0' -and $os.ServicePackMajorVersion -lt 2)
{
    # On Windows Server 2003 / XP x64, Service Pack 2 is required.
    throw 'This package requires Service Pack 2 to be installed first.'
}
elseif ($version -ge [Version]'5.1' -and $version -lt [Version]'5.2' -and $os.ServicePackMajorVersion -lt 3)
{
    # On Windows XP, Service Pack 3 is required.
    throw 'This package requires Service Pack 3 to be installed first.'
}

$runtimes = @{
    'x64' = @{ RegistryPresent = $false; RegistryVersion = $null; DllVersion = $null; InstallData = $installData64; Applicable = (Get-ProcessorBits) -eq 64 }
    'x86' = @{ RegistryPresent = $false; RegistryVersion = $null; DllVersion = $null; InstallData = $installData32; Applicable = $true }
}

Write-Verbose 'Analyzing uninstall information in the registry'
Set-StrictMode -Off
[array] $uninstallKeys = Get-UninstallRegistryKey @uninstallData
Set-StrictMode -Version 2
[array] $filteredUninstallKeys = $uninstallKeys | Where-Object { $_ -ne $null -and ($_.PSObject.Properties['SystemComponent'] -eq $null -or $_.SystemComponent -eq 0) }
foreach ($uninstallKey in $filteredUninstallKeys)
{
    if ($uninstallKey -eq $null)
    {
        # this might happen on PS 2.0
        continue
    }

    if ($uninstallKey.DisplayName -match '\((x((86)|(64)))\)')
    {
        $arch = $matches[1]
        $runtimes[$arch].RegistryPresent = $true
        Write-Verbose "Uninstall information for runtime for architecture $arch is present in the registry"
        if ($uninstallKey.PSObject.Properties['DisplayVersion'] -ne $null)
        {
            $versionString = $uninstallKey.DisplayVersion
            try
            {
                $runtimes[$arch].RegistryVersion = [version]$versionString
                Write-Verbose "Version of installed runtime for architecture $arch in the registry: $versionString"
            }
            catch
            {
                Write-Warning "The uninstall information in the registry is in an unknown format. Please report this to package maintainers. Data from the registry: DisplayVersion = [$versionString]"
            }
        }
    }
    else
    {
        Write-Warning "The uninstall information in the registry is in an unknown format. Please report this to package maintainers. Data from the registry: DisplayName = [$($uninstallKey.DisplayName)]"
    }
}

switch ([string](Get-ProcessorBits))
{
    '32' { $pathVariants = @{ x86 = "$Env:SystemRoot\System32"; x64 = $null } }
    '64' { $pathVariants = @{ x86 = "$Env:SystemRoot\SysWOW64"; x64 = "$Env:SystemRoot\System32" } }
    default { throw "Unsupported bitness: $_" }
}

Write-Verbose 'Analyzing version of DLLs present on the system'
foreach ($archAndPath in $pathVariants.GetEnumerator())
{
    $arch = $archAndPath.Key
    $path = $archAndPath.Value
    if ($path -eq $null)
    {
        continue
    }

    # the runtime consists of several DLLs, but all of them have the same version, so pick one
    $dllName = $otherData.DllName
    Write-Verbose "Determining presence of $dllName for architecture $arch"
    $dll = Get-Item -Path (Join-Path -Path $path -ChildPath $dllName) -ErrorAction SilentlyContinue
    if ($dll -eq $null -or $dll.VersionInfo -eq $null -or $dll.VersionInfo.ProductVersion -eq $null)
    {
        Write-Verbose "$dllName for architecture $arch is not present or does not contain version information"
        continue
    }

    Write-Verbose "$dllName for architecture $arch is present ($($dll.FullName))"
    $versionString = $dll.VersionInfo.ProductVersion
    try
    {
        $runtimes[$arch].DllVersion = [version]$versionString
        Write-Verbose "Version of $dllName architecture ${arch}: $versionString"
    }
    catch
    {
        Write-Warning "The $dllName version info is in an unknown format. Please report this to package maintainers. Data from the DLL: ProductVersion = [$versionString]"
    }
}

Write-Verbose "Version number of runtime installed by this package: $($otherData.Version)"
foreach ($archAndRuntime in $runtimes.GetEnumerator())
{
    $arch = $archAndRuntime.Key
    $runtime = $archAndRuntime.Value

    # The runtime should be installed if (both conditions must be met):
    # - there is no uninstall information in the registry or version in the registry is lower than installed by this package,
    # - the DLL does not exist or its version is not higher than installed by this package.
    # This logic handles the following cases:
    # 1) when the runtime is uninstalled, DLLs may be left behind on disk (so we need to look at uninstall info in the registry, or rather lack of it)
    # 2) later releases of the runtime may change the uninstall DisplayName (2015 -> vNext -> (probably) 2017),
    #    so the package will not detect uninstall information from a later or earlier "generation" (so we need to look at DLL version to detect if a newer release is installed)
    # The overall idea is to allow upgrades, disallow downgrades (unless forced by the user) and prevent unnecessary download and reinstall if the exact version is already installed.
    $laterDllVersionPresent = $runtime.DllVersion -ne $null -and $runtime.DllVersion -gt $otherData.Version
    $shouldInstall = -not $laterDllVersionPresent -and (-not $runtime.RegistryPresent -or $runtime.RegistryVersion -eq $null -or $runtime.RegistryVersion -lt $otherData.Version)
    Write-Verbose "Runtime for architecture $arch applicable: $($runtime.Applicable); present in registry: $($runtime.RegistryPresent); version in registry: [$($runtime.RegistryVersion)]; version of DLL: [$($runtime.DllVersion)]; should install: $shouldInstall"
    if ($runtime.Applicable)
    {
        if (-not $shouldInstall)
        {
            if ($force)
            {
                Write-Warning "Forcing installation of runtime for architecture $arch version $($otherData.Version) even though this or later version appears present, because 'Force' was specified in package parameters."
            }
            else
            {
                if ($laterDllVersionPresent)
                {
                    Write-Warning "Skipping installation of runtime for architecture $arch version $($otherData.Version) because a newer DLL version ($($runtime.DllVersion)) is present."
                }
                else
                {
                    Write-Host "Runtime for architecture $arch version $($otherData.Version) is already installed."
                }

                continue
            }
        }

        Write-Verbose "Installing runtime for architecture $arch"
        $installData = $runtime.InstallData
        Set-StrictMode -Off
        Install-ChocolateyPackage -PackageName "${packageName}-$arch" `
                                  -FileType $installerType `
                                  -SilentArgs $silentArgs `
                                  -ValidExitCodes $validExitCodes `
                                  @installData
        Set-StrictMode -Version 2
    }
}
