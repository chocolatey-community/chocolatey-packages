$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.61-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.61-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.61-1.win64-install.exe'
  checksum       = '0e534ea17cbe05c3fd833685d17d30610b01a0c9de6172e1b87a77b1772c496f'
  checksum64     = 'a2deebdcbe2bdac0b63ee07fd7f8aac6ccf61c129c474190732ad8fe70cc723e'
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
