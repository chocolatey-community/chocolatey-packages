$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.82-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.82-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.82-1.win64-install.exe'
  checksum       = '73bff2837cbf5f3ebd253139105d1db56f7cf19e8bb8792e2571240c1bd841ee'
  checksum64     = '07bfd3b95aa26578ae5f6f99023000927f466ec8453105aac63dc48b5a5f463f'
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
