$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'flashplayerplugin'
  fileType               = 'msi'
  url                    = 'https://download.macromedia.com/get/flashplayer/pdc/32.0.0.387/install_flash_player_32_plugin.msi'
  checksum               = '08480a2353a45563fe3ac4ac2f421b9fe8a14e3c5e585671e3485a364dacd725'
  checksumType           = 'sha256'
  silentArgs             = '/quiet /norestart REMOVE_PREVIOUS=YES'
  validExitCodes         = @(0)
  softwareName           = 'Adobe Flash Player *'
}
Install-ChocolateyPackage @packageArgs
