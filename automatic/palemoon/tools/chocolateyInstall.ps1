$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-29.2.1.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-29.2.1.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = '7e2fba0be362521b79943bb36c522f7cedb1e8b39d05bd89be7559bb2937adb3'
  checksumType  = 'sha256'
  checksum64    = 'dca237ca219bdcc0f6259baa72f5a26eca4fa24b8896839ae5f7e7cee153ced1'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
