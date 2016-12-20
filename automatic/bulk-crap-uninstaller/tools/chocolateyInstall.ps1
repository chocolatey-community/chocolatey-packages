$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.5/BCUninstaller_3.5_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.5/BCUninstaller_3.5_setup.exe'
  checksum               = '215695407efcd5f2096f7a4e98d02ddfdc89fa1e2ebdd63468393620bd014270'
  checksum64             = '215695407efcd5f2096f7a4e98d02ddfdc89fa1e2ebdd63468393620bd014270'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
