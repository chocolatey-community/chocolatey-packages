$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.59-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.59-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.59-1.win64-install.exe'
  checksum       = '1c86b561864ae86f06c90e28f76a75d131976227dc489664d05f85d99d5e8942'
  checksum64     = '88462a661f367b236f539e4f2bd5ee8293b3b5bbfc4b6fd64268b5df824807ca'
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
