$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-3.12-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-3.12-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.12-1.win64-install.exe'
  checksum       = '1ee9c29578f819cb9167c23b372b87142011e8fcd1bbc7f7d92e150ab126d5b2'
  checksum64     = 'e8f689e470f850a10e2b4feba80bfd3dc9c14a3a33aa5c5420c1335657b2b432'
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
