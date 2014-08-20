$packageName = 'ant-renamer'
$installerType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://update.antp.be/renamer/antrenamer2_install.exe'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url
