$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.12/BCUninstaller_3.12_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.12/BCUninstaller_3.12_setup.exe'
  checksum               = '2338399d5941128663ee2fb8446d772c53f08c0f0c86173e1ecd4958c4e224ea'
  checksum64             = '2338399d5941128663ee2fb8446d772c53f08c0f0c86173e1ecd4958c4e224ea'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
