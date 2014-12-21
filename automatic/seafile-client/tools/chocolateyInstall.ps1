$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/passive'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
