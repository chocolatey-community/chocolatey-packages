$packageName = 'seafile-client'
$fileType = 'msi'
$silentArgs = '/passive'
$url = 'https://bitbucket.org/haiwen/seafile/downloads/seafile-2.1.2-en.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url