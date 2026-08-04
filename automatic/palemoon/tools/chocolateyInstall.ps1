$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-34.3.2.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-34.3.2.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'bb6265a257796459a704679042fb508fd3a222eb6225d6dbdb6169d45de74a64'
  checksumType  = 'sha256'
  checksum64    = '5141b4716abcab4789c4f425395b1f2b5a3d99c094ea75e4382daed6ec67ab25'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
