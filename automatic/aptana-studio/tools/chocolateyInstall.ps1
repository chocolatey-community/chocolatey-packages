$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/passive /norestart'
$url = '{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
