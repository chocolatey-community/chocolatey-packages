$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.77-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.77-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.77-1.win64-install.exe'
  checksum       = '25a5554f3abca49c2c70ebe8ffefdb33248718ff439001eb98a6eeeac4da2189'
  checksum64     = 'c0dc4962d4808cf37089054f49550792744590cd24745a20b4083d87943d2c72'
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
