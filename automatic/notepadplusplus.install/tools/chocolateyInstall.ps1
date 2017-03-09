$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.3.3/npp.7.3.3.Installer.x64.exe'
$checksum32  = 'c59a2b8ba98d0bb849e55aa8ad1cfc9af54ed9acc1a087a43033e23bebedc0e8'
$checksum64  = '656e7a31ee07d7febcb49822dd166cb72afe23d4dccf546f2c6b45bcd959e5a1'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  registryUninstallerKey = 'notepad\+\+'
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
}
else { Write-Warning "Can't find $PackageName install location" }
