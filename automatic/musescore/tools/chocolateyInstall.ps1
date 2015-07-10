$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/passive /norestart'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
