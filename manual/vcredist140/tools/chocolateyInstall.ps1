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

switch ([string](Get-ProcessorBits))
{
  '32' { $registryRoots = @{ x86 = 'HKLM:\SOFTWARE'; x64 = $null } }
  '64' { $registryRoots = @{ x86 = 'HKLM:\SOFTWARE\WOW6432Node'; x64 = 'HKLM:\SOFTWARE' } }
  default { throw "Unsupported bitness: $_" }
}

Write-Verbose 'Analyzing servicing information in the registry'
foreach ($archAndRegRoot in $registryRoots.GetEnumerator())
{
  $arch = $archAndRegRoot.Key
  $regRoot = $archAndRegRoot.Value
  # https://docs.microsoft.com/en-us/cpp/ide/redistributing-visual-cpp-files
  $regData = Get-ItemProperty -Path "$regRoot\Microsoft\DevDiv\vc\Servicing\$($otherData.FamilyRegistryKey)\RuntimeMinimum" -Name 'Version' -ErrorAction SilentlyContinue
  if ($regData -ne $null)
  {
    $versionString = $regData.Version
    try
    {
      $parsedVersion = [version]$versionString
      Write-Verbose "Version of installed runtime for architecture $arch in the registry: $versionString"
      $normalizedVersion = [version]($parsedVersion.ToString(3)) # future-proofing in case Microsoft starts putting more than 3 parts here
      $runtimes[$arch].RegistryVersion = $normalizedVersion
    }
    catch
    {
      Write-Warning "The servicing information in the registry is in an unknown format. Please report this to package maintainers. Data from the registry: Version = [$versionString]"
    }
  }
}

$packageRuntimeVersion = $otherData.ThreePartVersion
Write-Verbose "Version number of runtime installed by this package: $packageRuntimeVersion"
foreach ($archAndRuntime in $runtimes.GetEnumerator())
{
  $arch = $archAndRuntime.Key
  $runtime = $archAndRuntime.Value

  $shouldInstall = $runtime.RegistryVersion -eq $null -or $runtime.RegistryVersion -lt $packageRuntimeVersion
  Write-Verbose "Runtime for architecture $arch applicable: $($runtime.Applicable); version in registry: [$($runtime.RegistryVersion)]; should install: $shouldInstall"
  if ($runtime.Applicable)
  {
    if (-not $shouldInstall)
    {
      if ($force)
      {
        Write-Warning "Forcing installation of runtime for architecture $arch version $packageRuntimeVersion even though this or later version appears present, because 'Force' was specified in package parameters."
      }
      else
      {
        if ($runtime.RegistryVersion -gt $packageRuntimeVersion)
        {
          Write-Warning "Skipping installation of runtime for architecture $arch version $packageRuntimeVersion because a newer version ($($runtime.RegistryVersion)) is already installed."
        }
        else
        {
          Write-Host "Runtime for architecture $arch version $packageRuntimeVersion is already installed."
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
