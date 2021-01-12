$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.79-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.79-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.79-1.win64-install.exe'
  checksum       = 'a7e314b69bf6590606224de651d19911d1cad0002eba0e17a790d2a503f1797a'
  checksum64     = '3c1cf51379aabab0507f4caa5357f823e4ea08ec4b48d3c9229268c780a1e0bb'
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
