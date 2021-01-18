$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.81-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.81-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.81-1.win64-install.exe'
  checksum       = '36c8f731caf1838266e9a9c1e68d55b2fe1effb08532b043cd0c328bf9412f26'
  checksum64     = '3b12e201dd08271a440e3bb34292dab71a85ee64fdc7b36286890927ba3b72b1'
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
