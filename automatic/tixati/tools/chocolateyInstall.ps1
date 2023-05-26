$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-3.19-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-3.19-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.19-1.win64-install.exe'
  checksum       = 'aba530275d136a63e927807d75a3d5ceb30990d15eedf00a12f5bd247f79b5e0'
  checksum64     = 'c696960f8bdade39e3a73d6a7626dbd9ecb79f8c9335c8ea1220015a55627692'
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
