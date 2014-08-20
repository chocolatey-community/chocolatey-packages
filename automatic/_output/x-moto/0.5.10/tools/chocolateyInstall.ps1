$packageName = 'x-moto'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://download.tuxfamily.org/xmoto/xmoto/0.5.10/xmoto-0.5.10-win32-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url