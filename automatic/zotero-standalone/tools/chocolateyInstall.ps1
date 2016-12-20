$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'zotero-standalone'
  fileType               = 'exe'
  url                    = 'https://download.zotero.org/standalone/4.0.29.10/Zotero-4.0.29.10_setup.exe'
  checksum               = '5acd661b5847b6e29dfdc83514e229b31160acf5faaa89b80f6117e3e871784b'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Zotero Standalone *'
}
Install-ChocolateyPackage @packageArgs
