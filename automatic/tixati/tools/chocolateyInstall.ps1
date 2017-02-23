$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.53-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.53-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.53-1.win64-install.exe'
  checksum       = '7c210e86d586a5e5773c0af39778ba87883db6dbe8ce1d5bcd4da341dfa1cc0e'
  checksum64     = 'b9a59a1d6bbde6fee773e0429a55afbdd792b42d59447ca5adea28966d12971c'
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
