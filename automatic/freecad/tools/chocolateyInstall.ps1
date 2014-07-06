$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as array of the download
# links due to limitations of Ketarin/chocopkgup
$urlArray = {{DownloadUrlx64}}
$url = $urlArray[0]
$url64 = $urlArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64