$packageName = 'seafile-client'
$fileType = 'msi'
$silentArgs = '/passive'
$url = 'http://seafile.googlecode.com/files/seafile-2.0.6-en.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url