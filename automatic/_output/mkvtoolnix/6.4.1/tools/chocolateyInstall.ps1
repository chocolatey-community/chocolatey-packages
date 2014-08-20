$packageName = 'mkvtoolnix'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://www.bunkus.org/videotools/mkvtoolnix/win32/?path=&download=mkvtoolnix-unicode-6.4.1-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url