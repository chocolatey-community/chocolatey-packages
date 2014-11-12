$packageName = 'owncloud-client'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'https://download.owncloud.com/desktop/stable/ownCloud-1.7.0.4162-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
