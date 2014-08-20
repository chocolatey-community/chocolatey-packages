$packageName = 'owncloud-client'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://download.owncloud.com/desktop/stable/ownCloud-1.5.3.2523-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url