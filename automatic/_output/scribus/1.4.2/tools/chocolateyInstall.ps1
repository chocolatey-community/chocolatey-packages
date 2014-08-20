$packageName = 'scribus'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://kent.dl.sourceforge.net/project/scribus/scribus/1.4.2/scribus-1.4.2-windows.exe'
$url64bit = 'http://garr.dl.sourceforge.net/project/scribus/scribus/1.4.2/scribus-1.4.2-windows-x64.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit