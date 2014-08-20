$packageName = 'haali-media-splitter'
$fileType = "exe"
$silentArgs = "/S"
$url = 'http://haali.su/mkv/MatroskaSplitter.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url