$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.5.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.5.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'c8e3efcd8d22f30725cd80acca8213f397645223fab371b9264483d6e97b4b0e'
  checksumType  = 'sha256'
  checksum64    = '20a16bee446e28ce426b72774ffcd406678e469ab8b479f1a47b57deee3a7c98'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
