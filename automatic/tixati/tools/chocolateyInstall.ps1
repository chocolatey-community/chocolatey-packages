$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.65-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.65-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.65-1.win64-install.exe'
  checksum       = '37ee8eb839753749ca79e724cc73504c8dfe67d47d7a7031f9c614b5a9e71672'
  checksum64     = 'ff949746aca4e4cb91c7c42a4a9fb4156253a1239e65ada707dd9e017222e5fa'
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
