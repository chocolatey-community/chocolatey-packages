$packageName = 'flightgear'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$url = 'http://ftp.igh.cnrs.fr/pub/flightgear/ftp/Windows/Setup FlightGear 2.10.0.3.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url