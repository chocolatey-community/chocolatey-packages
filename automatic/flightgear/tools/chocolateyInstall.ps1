$ErrorActionPreference = 'Stop'

$version = '2016.4.1'
$softwareName = "FlightGear v$version"

$packageArgs = @{
  packageName = 'flightgear'
  fileType    = 'exe'
  url         = 'http://ftp.igh.cnrs.fr/pub/flightgear/ftp/Windows/FlightGear-2016.4.1.exe'

  softwareName = $softwareName

  silentArgs   = '/VERYSILENT'
  validExitCodes = @(0)
}

$key = UninstallRegistryKey -SoftwareName $softwareName

if ($key) {
  Write-Host "FlightGear $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
