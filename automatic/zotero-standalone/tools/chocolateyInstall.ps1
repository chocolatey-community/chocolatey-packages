$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'zotero-standalone'
  fileType               = 'exe'
  url                    = 'https://download.zotero.org/standalone/4.0.29.17/Zotero-4.0.29.17_setup.exe'
  checksum               = 'e418922668133d9e24df8d2ca274b2d51ef2e565cbd91890cbbec14fedb8a3fb'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Zotero Standalone *'
}
Install-ChocolateyPackage @packageArgs
