$packageName = 'flightgear'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$url = 'http://ftp.icm.edu.pl/packages/flightgear/Windows/Setup FlightGear 3.0.0.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
