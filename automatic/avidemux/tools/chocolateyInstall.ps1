$ErrorActionPreference = 'Stop'

$packageName = 'avidemux'
$url32 = Get-UrlFromFosshub 'to_be_determined'
$url64 = Get-UrlFromFosshub 'to_be_determined'
$checksum32  = 'to_be_determined'
$checksum64  = 'to_be_determined'

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
  validExitCodes         = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
