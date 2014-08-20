$packageName = 'ietester'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.my-debugbar.com/ietester/install-ietester-v0.5.2.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url