$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.48-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.48-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.48-1.win64-install.exe'
  checksum       = '986618a29bace619193860993665c88f71e3dd147a43eedc6ee4337a534ba357'
  checksum64     = '155d569cc2bfc73d6be5892f7d0c1226ed002bcff6d3e56bdd2a5d5b58a4a47e'
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
