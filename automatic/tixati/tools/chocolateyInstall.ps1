$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.74-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.74-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.74-1.win64-install.exe'
  checksum       = 'f008f0301f4c62bc3347692f9f15559ca3465bf40d4dc34cc7bb78b7d9462db2'
  checksum64     = '42dea61b1470adcf5aaa79a954edc0f54f752afbfd7f3d2447e0fe90076f943b'
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
