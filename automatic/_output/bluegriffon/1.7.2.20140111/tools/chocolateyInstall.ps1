$packageName = 'bluegriffon'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
#$url = "http://bluegriffon.org/freshmeat/1.7/bluegriffon-1.7.exe"
$url = 'http://bluegriffon.org/freshmeat/1.7.2/bluegriffon-1.7.2.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url