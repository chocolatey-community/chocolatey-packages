$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.85-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.85-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.85-1.win64-install.exe'
  checksum       = 'a7ad2da4778e88b231c5b5411310eef81b97e17488d2d68dda2a489b07d1cf0e'
  checksum64     = 'cea0d7a8390f4954ded8d159406f991f1f2492c417fe55a4bacd48ed81a69c30'
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
