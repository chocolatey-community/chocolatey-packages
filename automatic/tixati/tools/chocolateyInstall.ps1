$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.88-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.88-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.88-1.win64-install.exe'
  checksum       = 'ce0ac18aabb48cd3360629996b4df06d816db41a1a681641661cf4d5f656d467'
  checksum64     = '780e8b7d2222462f3693711595ee8374e7d5b759121383e79c96b2fa8a59987e'
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
