$packageName = '{{PackageName}}'
$installerType = 'exe'
$silentArgs = '/VERYSILENT'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $installerType $silentArgs $url