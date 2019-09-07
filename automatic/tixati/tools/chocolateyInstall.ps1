$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.63-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.63-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.63-1.win64-install.exe'
  checksum       = '8c7b71ce341ec2cedf5d87f59ad900802c1a234717faa9a095778d349ea1ec70'
  checksum64     = '9151ce585009456b43087b2d4fc7e3ccb6e4e4484a1fde4097ac58d4569f3f27'
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
