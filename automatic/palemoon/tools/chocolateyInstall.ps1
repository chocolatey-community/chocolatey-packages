$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'palemoon'
  fileType      = 'exe'
  url           = 'https://rm-eu.palemoon.org/release/palemoon-33.0.0.win32.installer.exe'
  url64         = 'https://rm-eu.palemoon.org/release/palemoon-33.0.0.win64.installer.exe'

  softwareName  = 'Pale Moon*'

  checksum      = 'd9ba834986edb61c60c9d87a1caab3ba18d62557eefbf69bc7034ad6a6a6b274'
  checksumType  = 'sha256'
  checksum64    = 'b5af5874bfd00f5d18286294e87b4f278fed9c4cbf310eab215d33d3c824ce01'
  checksumType64= 'sha256'

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
