$packageName = 'qbittorrent'
$installerType = 'exe'
$url = 'http://master.dl.sourceforge.net/project/qbittorrent/qbittorrent-win32/qbittorrent-3.1.8/qbittorrent_3.1.8_setup.exe'
$silentArgs = '/S' 
$validExitCodes = @(0) 

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
