$packageName = '{{PackageName}}'
$fileType = 'exe'
$fileArgs = '/VERYSILENT'
$version = '{{PackageVersion}}'

$url = Get-UrlFromFosshub "http://www.fosshub.com/genLink/Audacity/audacity-win-${version}.exe"

Install-ChocolateyPackage $packageName $fileType $fileArgs $url
