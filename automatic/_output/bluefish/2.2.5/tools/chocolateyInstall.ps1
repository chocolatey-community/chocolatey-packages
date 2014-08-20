$packageName = 'bluefish'
$fileType = 'exe'
$silentArgs = '/S'
#$url = "http://www.bennewitz.com/bluefish/stable/binaries/win32/Bluefish-2.2.4-setup.exe"
$url = 'http://www.bennewitz.com/bluefish/stable/binaries/win32/Bluefish-2.2.5-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url