$ErrorActionPreference = 'Stop'

$version = '2016.4.1'
$softwareName = "FlightGear v$version"

$packageArgs = @{
  packageName = 'flightgear'
  fileType    = 'exe'
  url         = 'http://ftp.igh.cnrs.fr/pub/flightgear/ftp/Windows/FlightGear-2016.4.1.exe'

  softwareName = $softwareName

  checksum     = '8B1851999233047E3DA451AFB2739C5024E914E92011B3F5F37E42CDB5ED1F64'
  checksumType = ''

  silentArgs   = '/VERYSILENT'
  validExitCodes = @(0)
}

$key = UninstallRegistryKey -SoftwareName $softwareName

if ($key) {
  Write-Host "FlightGear $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
