$packageName = '{{PackageName}}'
$fileType = 'exe'
$fileArgs = '/S'

# In case you see \{\{DownloadUrlx64\}\} (without backslashes)
# after the commented lines, it’s intended.
$genLinkUrlArray = {{DownloadUrlx64}}
$url = Get-UrlFromFosshub $genLinkUrlArray[0]
$url64 = Get-UrlFromFosshub $genLinkUrlArray[1]

Install-ChocolateyPackage $packageName $fileType $fileArgs $url $url64
