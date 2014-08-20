$packageName = 'mkvtoolnix'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://www.bunkus.org/videotools/mkvtoolnix/win32/?path=&download=mkvtoolnix-6.7.0-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url