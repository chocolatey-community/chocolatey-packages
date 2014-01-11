$packageName = 'seafile-client'
$fileType = 'msi'
$silentArgs = '/passive'
$url = 'http://seafile.googlecode.com/files/seafile-2.1.1-en.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url