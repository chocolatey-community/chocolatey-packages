$packageName = 'tightvnc'
$fileType = 'msi'
$silentArgs = '/quiet /norestart'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit