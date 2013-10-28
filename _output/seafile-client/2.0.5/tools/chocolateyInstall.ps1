$packageName = 'seafile-client'
$fileType = 'msi'
$silentArgs = '/passive'
$url = 'http://seafile.googlecode.com/files/seafile-2.0.5-en.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url