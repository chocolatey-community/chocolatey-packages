$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.5/npp.7.5.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.5/npp.7.5.Installer.x64.exe'
$checksum32  = 'ee05e4e2887dfb2b81239183a240edc116fbd6b8f96233c26cc90d30c631a3d0'
$checksum64  = '8f406da5631a769bf0323889e07d504f4737b2b41a7f48cb0a67f50d77c59b60'

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
  softwareName   = 'Notepad\+\+'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  {  Write-Warning "Can't find $PackageName install location"; return }

Write-Host "$packageName installed to '$installLocation'"
Install-BinFile -Path "$installLocation\notepad++.exe" -Name 'notepad++'
