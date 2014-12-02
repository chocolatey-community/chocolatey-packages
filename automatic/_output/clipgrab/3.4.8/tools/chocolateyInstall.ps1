$packageName = 'clipgrab'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://clipgrab.de/download/clipgrab-3.4.8.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
