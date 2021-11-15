$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.86-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.86-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.86-1.win64-install.exe'
  checksum       = 'bf1b47430fb3f3f8f57f96566ca35ed0916d95242a3c3ae32403192916163f3f'
  checksum64     = '239d1396f6f416a433c763df636ead1550db8713aea040f8ab3258fc16f447bd'
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
