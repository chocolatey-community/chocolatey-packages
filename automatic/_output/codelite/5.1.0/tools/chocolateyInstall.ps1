$packageName = 'codelite'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://kent.dl.sourceforge.net/project/codelite/Releases/codelite-5.1/codelite-5.1.0-mingw4.7.1-wx2.9.4.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url