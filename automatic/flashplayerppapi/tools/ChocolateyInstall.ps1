$packageName = 'flashplayerppapi'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/32.0.0.293/install_flash_player_32_ppapi.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Flash Player PPAPI'
  checksum      = 'd8ffd8004989c72fe4db25c1b95f228b98d861e4605f838cc3b0b7f0b2369569'
  checksumType  = 'sha256'
}

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage @packageArgs
