$packageName = '{{PackageName}}'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$url = 'https://sourceforge.net/projects/flightgear/files/{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
