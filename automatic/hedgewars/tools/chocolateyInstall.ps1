$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
