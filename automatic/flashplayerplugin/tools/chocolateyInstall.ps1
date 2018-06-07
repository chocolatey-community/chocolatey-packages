$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'flashplayerplugin'
  fileType               = 'msi'
  url                    = 'https://download.macromedia.com/get/flashplayer/pdc/30.0.0.113/install_flash_player_30_plugin.msi'
  checksum               = 'c5eb6ae7035d4f335eddb46bc5c1fb1f55b35037f6aece37bc88dcf6de31ccf6'
  checksumType           = 'sha256'
  silentArgs             = '/quiet /norestart REMOVE_PREVIOUS=YES'
  validExitCodes         = @(0)
  softwareName           = 'Adobe Flash Player *'
}
Install-ChocolateyPackage @packageArgs
