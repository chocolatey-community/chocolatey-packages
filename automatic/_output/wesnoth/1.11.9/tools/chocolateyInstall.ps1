$packageName = 'wesnoth'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://optimate.dl.sourceforge.net/project/wesnoth/wesnoth/wesnoth-1.11.9/wesnoth-1.11.9-win32.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url