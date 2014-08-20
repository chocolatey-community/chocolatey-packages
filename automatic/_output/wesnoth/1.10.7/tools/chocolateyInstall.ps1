$packageName = 'wesnoth'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://garr.dl.sourceforge.net/project/wesnoth/wesnoth-1.10/wesnoth-1.10.7/wesnoth-1.10.7-win32.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url