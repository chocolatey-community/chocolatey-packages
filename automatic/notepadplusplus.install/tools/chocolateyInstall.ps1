$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.4.1/npp.7.4.1.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.4.1/npp.7.4.1.Installer.x64.exe'
$checksum32  = 'abd12e4848c6e6ccc48729426da4fae2479ef82df71340753e683674db7f2786'
$checksum64  = '7e63b7fb06ec318089193072485e96ac4edee5d277e1639d3f1a613885326cbc'

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
