$packageName = 'gnucash'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://downloads.sourceforge.net/sourceforge/gnucash/gnucash-2.4.13-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url