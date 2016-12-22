$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.51-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.51-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.51-1.win64-install.exe'
  checksum       = '68fb3dce6af2d986da584fc6ecb173041c45705f8451946345814f8824fcb462'
  checksum64     = '940b8ecc31100ad50b99d71babb65a2dff4e509543b1d85b4d55cfc237842dc4'
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
