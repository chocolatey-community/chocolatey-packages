$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-3.14-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-3.14-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-3.14-1.win64-install.exe'
  checksum       = '75db21e5200ae90bbfaea2118370856ea8261abcbd4a688b827d72a5c0f883cc'
  checksum64     = '4d80147cc3af1ba1f9ab9465baf8e2d6d0db5fc2a96c22a3570e9635d538bb82'
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
