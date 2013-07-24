$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://downloads.sourceforge.net/sourceforge/gnucash/gnucash-{{PackageVersion}}-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url