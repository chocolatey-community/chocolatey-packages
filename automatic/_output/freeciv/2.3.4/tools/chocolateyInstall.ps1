$packageName = 'freeciv'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://heanet.dl.sourceforge.net/project/freeciv/Freeciv 2.3/2.3.4/Freeciv-2.3.4-win32-gtk2-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url