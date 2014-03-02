$packageName = 'musescore'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://garr.dl.sourceforge.net/project/mscore/mscore/MuseScore-1.3/MuseScore-1.3.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url