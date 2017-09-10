$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.15/BCUninstaller_3.15_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.15/BCUninstaller_3.15_setup.exe'
  checksum               = 'da3eeb6c4abd62805fae0836cf26ef8413d368424c5fc04b8ee9d3da55fc5525'
  checksum64             = 'da3eeb6c4abd62805fae0836cf26ef8413d368424c5fc04b8ee9d3da55fc5525'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
