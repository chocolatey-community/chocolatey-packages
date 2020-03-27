$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.72-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.72-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.72-1.win64-install.exe'
  checksum       = '0728c2f3ae45d92693f7fbaea76ba75556d5b1609179cb4af5a1103aa280ec66'
  checksum64     = '8cd3814e26bc3f99e0e2774593bcf719a36625eab1b56935156bca0aa1ebb2f0'
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
