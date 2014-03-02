$packageName = 'owncloud-client'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://download.owncloud.com/download/owncloud-1.3.0-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url