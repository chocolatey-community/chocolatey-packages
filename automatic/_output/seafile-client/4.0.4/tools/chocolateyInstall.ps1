$packageName = 'seafile-client'
$fileType = 'msi'
$silentArgs = '/passive'
$url = 'https://bitbucket.org/haiwen/seafile/downloads/seafile-4.0.4-en.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
