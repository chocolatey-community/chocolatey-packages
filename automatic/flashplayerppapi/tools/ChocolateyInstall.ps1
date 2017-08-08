$packageName = 'flashplayerppapi'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/26.0.0.151/install_flash_player_26_ppapi.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Flash Player PPAPI'
  checksum      = '165d2dd231982fd8243397a8daa0992406640a708e249f51a28aa5495b95d95e'
  checksumType  = 'sha256'
}

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage @packageArgs
