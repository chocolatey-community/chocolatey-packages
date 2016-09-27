$packageName = 'svg-explorer-extension'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'https://svgextension.codeplex.com/downloads/get/803085'
$url64 = 'https://svgextension.codeplex.com/downloads/get/803086'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
