$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.2/BCUninstaller_3.8.2_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.8.2/BCUninstaller_3.8.2_setup.exe'
  checksum               = 'dda2ce41e436e0eb8ebbe8c9e091a3fdd3d1b100b13aeb5842bf9cc550495b08'
  checksum64             = 'dda2ce41e436e0eb8ebbe8c9e091a3fdd3d1b100b13aeb5842bf9cc550495b08'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
