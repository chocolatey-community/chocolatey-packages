$packageName = 'hedgewars'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://download.gna.org/hedgewars/hedgewars-win32.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url