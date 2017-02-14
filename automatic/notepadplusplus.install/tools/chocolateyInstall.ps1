$ErrorActionPreference = 'Stop'

$packageName = 'notepadplusplus'
$url32       = 'https://notepad-plus-plus.org/repository/7.x/7.3.2/npp.7.3.2.Installer.exe'
$url64       = 'https://notepad-plus-plus.org/repository/7.x/7.3.2/npp.7.3.2.Installer.x64.exe'
$checksum32  = '9c914b2922ad9fd625cfd507699b2589b9d68104d5f120304961d960cf201a89'
$checksum64  = '94f0b5c9ace8a431ca0be9e754a544d8434de918494ad17dedff28523b6bbcde'

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
