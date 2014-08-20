$packageName = 'tv-browser'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://kent.dl.sourceforge.net/project/tvbrowser/TV-Browser Releases (Java 6 and higher)/3.3.1/tvbrowser_3.3.1_win32.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url