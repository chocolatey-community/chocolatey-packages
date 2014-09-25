$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/passive /norestart'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
