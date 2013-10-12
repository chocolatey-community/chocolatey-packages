$packageName = 'alldup'
$installerType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://www.allsync.de/download/alldup.exe'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url