$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-3.17-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-3.17-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.17-1.win64-install.exe'
  checksum       = '0096d57a3e1d20efee333e562ffc0c860ea1efb1d5ac8719ac6c20d0a4ff0f87'
  checksum64     = '939622fcb826c4c84e563afab16e97deace9bd0243294dff37c01c81fd2eb98b'
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
