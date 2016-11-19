$ErrorActionPreference = 'Stop'

$version = '2016.3.1'
$softwareName = "FlightGear v$version"

$packageArgs = @{
  packageName = 'flightgear'
  fileType    = 'exe'
  url         = 'http://ftp.igh.cnrs.fr/pub/flightgear/ftp/Windows/FlightGear-2016.3.1.exe'

  softwareName = $softwareName

  checksum     = '3cbc1ab7f0cbbb9b3c98901b22b7ca7cca882d3904ba8b31fbb94fdf21b4e8b3'
  checksumType = 'sha256'

  silentArgs   = '/VERYSILENT'
  validExitCodes = @(0)
}

$key = UninstallRegistryKey -SoftwareName $softwareName

if ($key) {
  Write-Host "FlightGear $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
