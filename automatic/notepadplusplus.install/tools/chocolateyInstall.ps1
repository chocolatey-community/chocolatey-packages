$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.3/npp.7.3.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.3/npp.7.3.Installer.x64.exe'
$checksum32  = '07bbaac66fec3c697387aa56f52e8926e514de72876e2f9d4c40224101e6143b'
$checksum64  = '857a71b794695839181706c689b36f23a8ffa64eb060b49cb860a2dfe8315e38'

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
