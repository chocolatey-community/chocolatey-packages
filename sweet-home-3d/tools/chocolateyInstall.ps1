$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = '{{DownloadUrlx64}}' # { {DownloadUrlx64} } is not the actual 64-bit URL. It’s only a workaround for files hosted on SourceForge and contains the 32-bit URL

Install-ChocolateyPackage $packageName $fileType $silentArgs $url