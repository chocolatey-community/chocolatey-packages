$packageName = 'gnucash'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://netcologne.dl.sourceforge.net/project/gnucash/gnucash (stable)/2.4.13/gnucash-2.4.13-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url