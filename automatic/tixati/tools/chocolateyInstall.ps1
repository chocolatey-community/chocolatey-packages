$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.84-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.84-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.84-1.win64-install.exe'
  checksum       = '9649e0681252a27954c8ec173d7fc7a431370666945a765ed6c0d2c90f66cec6'
  checksum64     = '5e8e6069657b27f8f36091263923eef195dfbed3ce719590a2bc16e9f5205839'
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
