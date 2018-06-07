$packageName = 'flashplayerppapi'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  url           = 'https://download.macromedia.com/pub/flashplayer/pdc/30.0.0.113/install_flash_player_30_ppapi.msi'
  silentArgs    = '/quiet /norestart REMOVE_PREVIOUS=YES'
  softwareName  = 'Flash Player PPAPI'
  checksum      = 'c304f19a278bb749e578bdaa2f906762a2cf9db4e3001e16d51aa75d3aea0fcb'
  checksumType  = 'sha256'
}

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage @packageArgs
