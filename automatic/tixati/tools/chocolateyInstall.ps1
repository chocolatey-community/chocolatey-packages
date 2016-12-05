$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.49-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.49-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.49-1.win64-install.exe'
  checksum       = '6faf627170f0244d19510cd65c5d7a5a7c3d9e284001d1ff0999cf44712e6b6e'
  checksum64     = '2f7a29dc72a96d8def728f4eb1b0553066fe83fa888041bc7934f753e1d70d09'
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
