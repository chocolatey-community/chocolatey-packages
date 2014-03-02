$packageName = 'picard'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://ftp.musicbrainz.org/pub/musicbrainz/picard/picard-setup-1.2.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url