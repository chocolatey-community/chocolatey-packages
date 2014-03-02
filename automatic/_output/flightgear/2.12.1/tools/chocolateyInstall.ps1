$packageName = 'flightgear'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$url = 'http://fgfs.physra.net/ftp/Windows/Setup FlightGear 2.12.1.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url