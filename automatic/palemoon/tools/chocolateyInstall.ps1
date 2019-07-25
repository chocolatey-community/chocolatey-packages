$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'http://rm-eu.palemoon.org/release/palemoon-28.6.1.win32.installer.exe'
  url64         = 'http://rm-eu.palemoon.org/release/palemoon-28.6.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '6dc52ea820ebe0ea7b0f8f8005fa0eee045acc4e72fe7b879cab06eef6c8ebfa'
  checksumType  = 'sha256'
  checksum64    = '31d433a8fb26dc1acc3d0449f5bea7c2fbba6c20d707fd9a76f0d16623b899ce'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
