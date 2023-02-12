$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-3.16-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-3.16-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.16-1.win64-install.exe'
  checksum       = '1a783659414143ba19abb21e016a716feb52ca70c268a676c97fa1ca986f6612'
  checksum64     = '588cae93ea780dd51e4c001471441eb26693aaa978ff1f8c10396cd4dc43ba56'
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
