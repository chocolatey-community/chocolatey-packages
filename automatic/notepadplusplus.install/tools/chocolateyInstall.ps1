$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.3.1/npp.7.3.1.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.3.1/npp.7.3.1.Installer.x64.exe'
$checksum32  = '0cf11069ccf6a069a41959b859b71a789c536c0e5d6d2bc5669530eb87d407ab'
$checksum64  = '1355b690f500addd3af9d8d6657ebc6a47b30845bfd067026082e37fe70e4b54'

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
