$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.76-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.76-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.76-1.win64-install.exe'
  checksum       = 'aab84679c69cc8f07da4500d1b6c000b54e09be34e82051e82c39dfebd648cba'
  checksum64     = '1f814c049eb29abee6ea6fbe2442e991c93b06226a08658d791eb4ff0443bb13'
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
