$packageName = 'owncloud-client'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://download.owncloud.com/desktop/stable/ownCloud-1.5.2.2445-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url