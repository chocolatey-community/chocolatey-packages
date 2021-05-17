$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.83-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.83-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.83-1.win64-install.exe'
  checksum       = '5c5fe1e5635124e91865529eb111a2ff73f87ed6d3c4aac9a6c72921ecb72302'
  checksum64     = 'eff300f6e9bcdddda5b70cb352100d330504cddb7ec5bf63ffdcfb8bcf704d1f'
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
