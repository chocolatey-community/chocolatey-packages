$ErrorActionPreference = 'Stop'

$packageName = 'mkvtoolnix'
$url32 = Get-UrlFromFosshub 'https://www.fosshub.com/MKVToolNix.html/mkvtoolnix-32bit-9.5.0-setup.exe'
$url64 = Get-UrlFromFosshub 'https://www.fosshub.com/MKVToolNix.html/mkvtoolnix-64bit-9.5.0-setup.exe'
$checksum32  = '3b6f0f8b69bb9a4f3cfd560ccf740869ebf159229213dd52c321f2abc2c1cbfc'
$checksum64  = '001b06cfda2074afd5d3f563a0569a7cab58933f3590121f151d60c9282e7f0a'

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
