$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlsArray = {{DownloadUrlx64}}
$url = $urlsArray[0]
$url64bit = $urlsArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit
