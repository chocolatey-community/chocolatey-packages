$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.67-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.67-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.67-1.win64-install.exe'
  checksum       = 'c453eaec4a4a2e3592ab5a9c36b86134f3cca121117edc1fad33162656b139df'
  checksum64     = '6f33cc575aaaff2aba4cd7f10e23e858c8ccb86c8b62410b115eb3e0f2a48199'
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
