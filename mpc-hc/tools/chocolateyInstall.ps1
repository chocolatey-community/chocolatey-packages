$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$urlArray = {{DownloadUrlx64}} # { {DownloadUrlx64} } here is not the actual 64-bit URL, but it’s an array that contains both 32- and 64-bit URLs.
$url = $urlArray[0] 
$url64bit = $urlArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit