$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.47-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.47-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.47-1.win64-install.exe'
  checksum       = '7ba5b8d7036447d7c1ea6b1b8d003dd18b10b44cc9fa283d5999cd7f7821561a'
  checksum64     = '1210253a10f6fe1bc3e0432a810a1580617a2835a5bdcd44f03a9a8e25ba80a2'
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
