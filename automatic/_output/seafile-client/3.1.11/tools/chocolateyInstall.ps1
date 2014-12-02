$packageName = 'seafile-client'
$fileType = 'msi'
$silentArgs = '/passive'
$url = 'https://bitbucket.org/haiwen/seafile/downloads/seafile-3.1.11-en.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
