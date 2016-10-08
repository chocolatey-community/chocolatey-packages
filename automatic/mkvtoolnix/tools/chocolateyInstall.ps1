$ErrorActionPreference = 'Stop'

$packageName = 'mkvtoolnix'
$url32 = Get-UrlFromFosshub 'https://www.fosshub.com/MKVToolNix.html/mkvtoolnix-32bit-9.4.2-setup.exe'
$url64 = Get-UrlFromFosshub 'https://www.fosshub.com/MKVToolNix.html/mkvtoolnix-64bit-9.4.2-setup.exe'
$checksum32  = '66ce6fd8cf9d5aed6a8084aa659e3cc009b5ff2fb9c982a95b8e7f653dc86846'
$checksum64  = '40cb363f7c6160df1da4851a6ed409afcc9945871b234393173c6800b3ee9ac1'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  url64bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
