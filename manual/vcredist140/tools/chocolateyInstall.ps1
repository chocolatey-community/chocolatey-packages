. (Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent) -ChildPath 'data.ps1')
$packageName = 'vcredist140'
$installerType = 'exe'
$silentArgs = '/quiet /norestart'
$validExitCodes = @(0, 3010)

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
