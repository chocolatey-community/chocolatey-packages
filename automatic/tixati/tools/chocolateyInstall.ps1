$ErrorActionPreference = 'Stop'

$packageName = 'tixati'
$fileName = 'tixati-2.73-1.install.exe'
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$packageArgs = @{
  packageName    = $packageName
  fileFullPath   = "$download_dir\$fileName"
  url            = 'https://download1.tixati.com/download/tixati-2.73-1.win32-install.exe'
  url64bit       = 'https://download1.tixati.com/download/tixati-2.73-1.win64-install.exe'
  checksum       = 'b5ee493402e270f49808cb3184a42b0de79fdb1a3ff6cc8c77e142bcecb2f83a'
  checksum64     = '4e7b1657ef28cac396606f7a05a2a19145b252452a78d9dbe7af682dbc548971'
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
