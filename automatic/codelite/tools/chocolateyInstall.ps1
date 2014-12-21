$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = '{{DownloadUrlx64}}' # This variable is actually not the 64-bit installer, it is only a workaround to get the automatic package working

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
