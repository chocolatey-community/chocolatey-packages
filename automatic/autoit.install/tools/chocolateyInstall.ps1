$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\autoit-v3-setup.exe"
$extractedDestination = "$env:TEMP\$env:ChocolateyPackageName\$env:ChocolateyPackageVersion"

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  FileType       = 'exe'
  SoftwareName   = 'AutoIt*'
  File           = $filePath
  SilentArgs     = '/S'
  ValidExitCodes = @(0)
  destination    = $extractedDestination
}

Write-Host "Extracting embedded archive to cache location."
Get-ChocolateyUnzip @packageArgs

$packageArgs['File'] = "$extractedDestination\autoit-v3-setup.exe"

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and archive as there is no more need for it
Remove-Item -Force $filePath, $extractedDestination -Recurse
