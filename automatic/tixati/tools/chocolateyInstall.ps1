$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.55-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.55-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.55-1.win64-install.exe'
  checksum       = 'aa1767518733f84dab3b4e14ba92566a83ce83fa34be9c55a10e43bdff094fe9'
  checksum64     = 'eeb23e45af2fee7e370ace1da1515b8c4ef6efba6e4d7bfc4aabfefe4eb28d6b'
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
