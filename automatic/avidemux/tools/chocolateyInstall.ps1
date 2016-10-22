$ErrorActionPreference = 'Stop'

$packageName = 'avidemux'
$url32 = Get-UrlFromFosshub 'https://www.fosshub.com/Avidemux.html/avidemux_2.6.14_win32.exe'
$url64 = Get-UrlFromFosshub 'https://www.fosshub.com/Avidemux.html/avidemux_2.6.14_win64.exe'
$checksum32  = '627b177ae388b782326a2cf1142551d96769f906afb367034d9a6f3b28ed560f'
$checksum64  = '36f6b5406e44c74cd8144ea126e231894e5f5cf4640ed96120b6d3c3f4a6a120'

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
