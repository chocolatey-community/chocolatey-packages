$packageName = "spotify"
$fileType = "exe"
$args = "--uninstall -s"
$filePath = "$env:APPDATA\Spotify\Spotify.exe"
 
Uninstall-ChocolateyPackage $packageName $fileType $args $filePath