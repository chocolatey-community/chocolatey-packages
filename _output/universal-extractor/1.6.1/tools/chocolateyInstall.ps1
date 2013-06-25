$packageName = 'universal-extractor'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://www.legroom.net/files/software/uniextract161.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url