$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'flashplayerplugin'
  fileType               = 'msi'
  url                    = 'https://download.macromedia.com/get/flashplayer/pdc/27.0.0.170/install_flash_player_27_plugin.msi'
  checksum               = 'b5593c299af962ff484a85cc857c9f559e302ae8789abadd962bf0a6a85a08c0'
  checksumType           = 'sha256'
  silentArgs             = '/quiet /norestart REMOVE_PREVIOUS=YES'
  validExitCodes         = @(0)
  softwareName           = 'Adobe Flash Player *'
}
Install-ChocolateyPackage @packageArgs
