$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
#$url = "http://bluegriffon.org/freshmeat/1.7/bluegriffon-1.7.exe"
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
