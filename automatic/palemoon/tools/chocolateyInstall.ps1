$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-28.17.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-28.17.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'ea74da9bb029c8079ed437a3af1665f01c3c86259e5bb125faa6bfc7b2dec6d1'
  checksumType  = 'sha256'
  checksum64    = 'f663dcbaaa8531271d89d6015bcb0effecc3f856e9378bf3685050ba6e1051f9'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
