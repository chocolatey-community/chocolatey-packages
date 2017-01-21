$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.6.2/BCUninstaller_3.6.2_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.6.2/BCUninstaller_3.6.2_setup.exe'
  checksum               = 'eb37cfa2328effd55129669a748f3f65e2a30f037ce00333e28dc535c911cb27'
  checksum64             = 'eb37cfa2328effd55129669a748f3f65e2a30f037ce00333e28dc535c911cb27'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
