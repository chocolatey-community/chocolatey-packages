$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.4/npp.7.4.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.4/npp.7.4.Installer.x64.exe'
$checksum32  = 'c14f0c03636044bf4c85d007d9b6fd4aa88278549979d4905c6091088db94d2d'
$checksum64  = 'a95dcb3726b48adfd4a3364176c0291151e6c79630cab268a9ef3511860418d8'

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
