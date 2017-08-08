$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'flashplayerplugin'
  fileType               = 'msi'
  url                    = 'https://download.macromedia.com/get/flashplayer/pdc/26.0.0.151/install_flash_player_26_plugin.msi'
  checksum               = '28f692b79090178710fbf8b9c8403014d3ab5f1cff18b6f8fe41e853671e10b6'
  checksumType           = 'sha256'
  silentArgs             = '/quiet /norestart REMOVE_PREVIOUS=YES'
  validExitCodes         = @(0)
  softwareName           = 'Adobe Flash Player *'
}
Install-ChocolateyPackage @packageArgs
