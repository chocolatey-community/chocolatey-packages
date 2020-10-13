$packageName = 'flashplayerppapi'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/32.0.0.445/install_flash_player_32_ppapi.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Flash Player PPAPI'
  checksum      = '9f188d1d85eeeeb0757a2d5cefc1a273b2f1d24c32b99816804d7bd8b2ef9af5'
  checksumType  = 'sha256'
}

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage @packageArgs
