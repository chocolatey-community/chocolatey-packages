$packageName = 'flightgear'
$fileType = "exe"
$silentArgs = "/VERYSILENT"
$url = 'http://fgfs.physra.net/ftp/Windows/Setup FlightGear 3.0.0.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url