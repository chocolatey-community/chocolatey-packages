$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'flashplayerplugin'
  fileType               = 'msi'
  url                    = 'https://download.macromedia.com/get/flashplayer/pdc/28.0.0.161/install_flash_player_28_plugin.msi'
  checksum               = '8a41bc6102a3786c4bcae5146dbadef64ccb3d27f1ef6576c5ba8258db6bf213'
  checksumType           = 'sha256'
  silentArgs             = '/quiet /norestart REMOVE_PREVIOUS=YES'
  validExitCodes         = @(0)
  softwareName           = 'Adobe Flash Player *'
}
Install-ChocolateyPackage @packageArgs
