$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.64-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.64-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.64-1.win64-install.exe'
  checksum       = '997808b1d252e44508db50c284935c6012835076445fbeba6de8f989edddc0fb'
  checksum64     = '2e6252380971cf13e04c43334b5ed30edfbc2c17f4d4c45bac7e01fe4d3229d8'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Write-Output "Running Autohotkey installer"
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
Autohotkey.exe $toolsPath\$packageName.ahk $packageArgs.fileFullPath

$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
