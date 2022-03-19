$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.89-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.89-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.89-1.win64-install.exe'
  checksum       = '0dd570229ea30710b6157a6fd2f5575f04d8c66400bd4b00706acaf675eb9745'
  checksum64     = 'c59df9eea6a7f794a72e5888f49c01aea1bfab87ca7624df9ff491b883005c96'
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
