$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.4/BCUninstaller_3.8.4_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.4/BCUninstaller_3.8.4_setup.exe'
  checksum               = '390c140dc178d6c43ca3cb09254897fbbf23921f6dfdbc2e2189aa63ef0e447d'
  checksum64             = '390c140dc178d6c43ca3cb09254897fbbf23921f6dfdbc2e2189aa63ef0e447d'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
