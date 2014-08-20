$packageName = 'gnucash'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://downloads.sourceforge.net/sourceforge/gnucash/gnucash-2.6.0-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url