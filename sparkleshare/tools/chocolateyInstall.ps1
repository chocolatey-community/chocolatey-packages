$packageName = '{{PackageName}}'
$fileType = 'msi'
$silentArgs = '/qn'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url