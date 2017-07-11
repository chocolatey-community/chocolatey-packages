$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'zotero-standalone'
  fileType               = 'exe'
  url                    = 'https://download.zotero.org/client/release/5.0/Zotero-5.0_setup.exe'
  checksum               = '2743d0eda392d67983f51017264ee5766406c0d474d44f42364004beb8453de9'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Zotero Standalone *'
}
Install-ChocolateyPackage @packageArgs
