$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.87-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.87-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.87-1.win64-install.exe'
  checksum       = '99e204cb2b1b6814fc1175caf516966d9f76e133ded28f955759c3af93f1cd38'
  checksum64     = 'd4d72b9c7c234e00e18d1798ae568bf73b17dd5e208a11158e5c33b35de47319'
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
