$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.58-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.58-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.58-1.win64-install.exe'
  checksum       = 'b3041f3bcec00ac9fdd14a15f1e46cacc8d4c44890ceea9bf7d271ecf5091526'
  checksum64     = 'fa26583def1264dfa6bb48d4948adb19ce1fe623da5237943e804b5762f8172c'
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
