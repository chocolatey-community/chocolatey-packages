$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.Installer.x64.exe'
$checksum32  = 'abe92fc51f996eed9fa4953fefe5f904c009d0fbfb2b8a50aaec79ae8a9689be'
$checksum64  = 'bb89c0811f8566c21eda6e5880added61204eba0f13de9631f91e7e4c768cccd'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url32
  url64bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Notepad++*'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  {  Write-Warning "Can't find $PackageName install location"; return }

Write-Host "$packageName installed to '$installLocation'"
Install-BinFile -Path "$installLocation\notepad++.exe" -Name 'notepad++'
