$packageName = 'freeciv'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://optimate.dl.sourceforge.net/project/freeciv/Freeciv 2.4/2.4.2/Freeciv-2.4.2-win32-gtk2-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url