$packageName = 'flashplayerppapi'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/32.0.0.314/install_flash_player_32_ppapi.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Flash Player PPAPI'
  checksum      = 'f8784fcfe87a51fc64db03b717630b0e125b1d660f662d7091feb35bac87c752'
  checksumType  = 'sha256'
}

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage @packageArgs
