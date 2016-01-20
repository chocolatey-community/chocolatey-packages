$packageName = 'flashpluginppapi'
$version = '20.0.0.286'
$installerType = 'exe'
$url = 'https://fpdownload.adobe.com/pub/flashplayer/pdc/20.0.0.286/install_flash_player_ppapi.exe'
$silentArgs = '-install'
$validExitCodes = @(0)

#installer automatically overrides existing PPAPI installation
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes
