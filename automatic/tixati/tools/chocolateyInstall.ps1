$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.78-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.78-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.78-1.win64-install.exe'
  checksum       = '8e459278adfc1309168b8992d880a8a493bfd22b64e7983a02dc709c0337f9a0'
  checksum64     = '96737e7352e2ff039b7fcd69463e5f347b78b47162a150932e7c0e3364b1f65b'
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
