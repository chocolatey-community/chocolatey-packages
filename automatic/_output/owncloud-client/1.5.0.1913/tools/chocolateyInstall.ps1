$packageName = 'owncloud-client'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://download.owncloud.com/desktop/stable/ownCloud-1.5.0.1913-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url