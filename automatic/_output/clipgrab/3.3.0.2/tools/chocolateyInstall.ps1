$packageName = 'clipgrab'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://clipgrab.de/download/clipgrab-3.3.0.2.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url