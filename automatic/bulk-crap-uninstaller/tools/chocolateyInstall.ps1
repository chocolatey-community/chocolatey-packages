$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'bulk-crap-uninstaller'
  fileType               = 'exe'
  url                    = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.7.2/BCUninstaller_3.7.2_setup.exe'
  url64bit               = 'https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v3.7.2/BCUninstaller_3.7.2_setup.exe'
  checksum               = '1803a6d31f7fb0826f5f3bffb7ba89a85c1adc553d694f359d7983896558ae95'
  checksum64             = '1803a6d31f7fb0826f5f3bffb7ba89a85c1adc553d694f359d7983896558ae95'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes         = @(0)
  softwareName           = 'Bulk Crap Uninstaller'
}
Install-ChocolateyPackage @packageArgs
