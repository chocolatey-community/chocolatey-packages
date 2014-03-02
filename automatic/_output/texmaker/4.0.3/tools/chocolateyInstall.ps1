$packageName = 'texmaker'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.xm1math.net/texmaker/texmakerwin32_install.exe'
Install-ChocolateyPackage $packageName $fileType $silentArgs $url