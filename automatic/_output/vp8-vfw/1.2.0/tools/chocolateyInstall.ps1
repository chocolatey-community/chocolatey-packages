$packageName = 'vp8-vfw'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://www.optimasc.com/products/vp8vfw/vp8vfw-setup-1.2.0.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url