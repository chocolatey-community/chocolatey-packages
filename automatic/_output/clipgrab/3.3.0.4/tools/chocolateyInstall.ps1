$packageName = 'clipgrab'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://clipgrab.de/download/clipgrab-3.3.0.4.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url