$packageName = 'owncloud-client'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://download.owncloud.com/desktop/stable/ownCloud-1.7.1.4382-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
