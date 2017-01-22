. (Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -ChildPath 'data.ps1')
$packageName = 'vcredist140'
$installerType = 'exe'
$silentArgs = '/quiet /norestart'
$validExitCodes = @(0, 3010)

$os = Get-WmiObject -Class Win32_OperatingSystem
$version = [Version]$os.Version
if ($version -ge [Version]'6.1' -and $version -lt [Version]'6.2' -and $os.ServicePackMajorVersion -lt 1)
{
    # On Windows 7, Service Pack 1 is required.
    throw 'This package requires Service Pack 1 to be installed first. The "KB976932" package may be used to install it.'
}

Install-ChocolateyPackage -PackageName $packageName `
                          -FileType $installerType `
                          -SilentArgs $silentArgs `
                          -ValidExitCodes $validExitCodes `
                          @installData32 `
                          @installData64

if ((Get-ProcessorBits) -eq 64)
{
    Write-Verbose "Installing also 32bit version on 64bit operating system."
    Install-ChocolateyPackage -PackageName $packageName `
                              -FileType $installerType `
                              -SilentArgs $silentArgs `
                              -ValidExitCodes $validExitCodes `
                              @installData32 `
}
