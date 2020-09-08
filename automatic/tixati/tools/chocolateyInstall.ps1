$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.75-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.75-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.75-1.win64-install.exe'
  checksum       = 'fd330379932c0bd8fd49beaacc05f85a0d41dbcdd51ca4d010df8b6e144034b7'
  checksum64     = '2bf040d9a1bb965ed3486aa0ad0f37feb6bad8aaf3fc3c012381524e4ebd8446'
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
