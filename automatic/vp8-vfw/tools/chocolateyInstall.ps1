$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
