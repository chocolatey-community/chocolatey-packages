$packageName = 'scribus'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/scribus/files/scribus/1.4.3/scribus-1.4.3-windows.exe/download'
$url64bit = 'http://sourceforge.net/projects/scribus/files/scribus/1.4.3/scribus-1.4.3-windows-x64.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit