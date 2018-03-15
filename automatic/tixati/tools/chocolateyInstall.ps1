$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.57-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.57-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.57-1.win64-install.exe'
  checksum       = '08dcd33976f3122cc019c58452e26e00b3b8e861004b0aa2c2484a6ff3d0f07c'
  checksum64     = 'e40265e57eaaa58ed75ef612b45dc840fae3795b4ddc0cdb20275912c38bbef7'
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
