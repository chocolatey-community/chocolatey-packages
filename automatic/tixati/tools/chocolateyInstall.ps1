$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-3.11-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-3.11-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.11-1.win64-install.exe'
  checksum       = '4b32578d194b348ac8a9d3fd86eadd72f5029bdcec45d884849b1cd1faa9455e'
  checksum64     = '0510697b4f89e76ebd064551a1e17b9294bf0bdf417685ff338e4280dbf307ea'
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
