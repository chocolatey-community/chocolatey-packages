$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$language_code = if ($pp.LanguageCode) { Write-Host "Using language code $($pp.LanguageCode)"; 'L=' + $pp.LanguageCode }

$packageArgs = @{
  packageName            = 'VLC'
  fileType               = 'exe'
  url                    = 'http://get.videolan.org/vlc/2.2.4/win32/vlc-2.2.4-win32.exe'
  url64bit               = 'http://get.videolan.org/vlc/2.2.4/win64/vlc-2.2.4-win64.exe'
  checksum               = 'f4a4b8897e86f52a319ee4568e62be9cda1bcb2341e798da12e359d81cb36e51'
  checksum64             = 'a283b1913c8905c4d58787f34b4a85f28f3f77c4157bee554e3e70441e6e75e4'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/S $language_code"
  validExitCodes         = @(0)
  softwareName           = 'VLC*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
