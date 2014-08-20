$packageName = 'bluefish'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.bennewitz.com/bluefish/stable/binaries/win32/Bluefish-2.2.6-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
