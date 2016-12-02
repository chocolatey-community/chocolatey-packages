$ErrorActionPreference = 'Stop'

$packageName = 'avidemux'
$checksum32  = 'b4bbf5bf995dbaca3ea9ca8b87a0c69de5ccedf9de95cc3d7c942b5305fa0fe7'
$checksum64  = '8ff161d5714f148f9a316e2bca1e01080bfb12222ba5991d8edab859b4072814'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = 'https://www.fosshub.com/Avidemux.html/avidemux_2.6.15_win32.exe'
  url64bit               = 'https://www.fosshub.com/Avidemux.html/avidemux_2.6.15_win64.exe'
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0, 1223)
}

Install-ChocolateyFosshub @packageArgs
