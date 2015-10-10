$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'

# Version-specific download links would be better, but they are only available on SourceForge,
# plus they are inconsistently named and thus not easily fetchable for auto-packages.
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
