$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
