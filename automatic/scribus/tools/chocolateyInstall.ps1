$packageName = 'scribus'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlArray = {{DownloadUrlx64}}
$url = $urlArray[0]
$url64bit = $urlArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
