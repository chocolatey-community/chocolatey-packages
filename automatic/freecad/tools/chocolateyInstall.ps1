$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'

$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
