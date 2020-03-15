$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.69-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.69-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.69-1.win64-install.exe'
  checksum       = 'ee9af97c97fce3e395787f51f9016ce114670736b9ea19533f51cc20887eb47d'
  checksum64     = '4b02f3685adfbf20828e278cb2dc16b9f9e80d3d1daabffcc9f610fb69a48dde'
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
