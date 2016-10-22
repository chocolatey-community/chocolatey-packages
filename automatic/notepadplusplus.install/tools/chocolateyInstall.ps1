$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.0/npp.7.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.0/npp.7.Installer.x64.exe'
$checksum32  = '0155c4ab117d63ba5142fc1090debc07dc7953264f7202ef8d25014e2cf8668d'
$checksum64  = 'a684a51b6e95420aebbbee4c67548db91e48dc506836fad30179e622fa5c30a7'

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
    #Register-Application "$installLocation\$packageName.exe"
    #Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
