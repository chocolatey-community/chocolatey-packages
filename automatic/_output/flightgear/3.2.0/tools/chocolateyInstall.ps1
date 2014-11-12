$packageName = 'flightgear'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$url = 'http://ftp.igh.cnrs.fr/pub/flightgear/ftp/Windows/Setup FlightGear 3.2.0.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
