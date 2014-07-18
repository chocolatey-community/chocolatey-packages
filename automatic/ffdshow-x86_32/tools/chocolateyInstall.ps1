$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# \{\{DownloadUrlx64\}\} gets “misused” here as has to store both 32- and 64-bit URLs
$urlHash = {{DownloadUrlx64}}

Install-ChocolateyPackage $packageName $fileType $silentArgs $urlHash.url32