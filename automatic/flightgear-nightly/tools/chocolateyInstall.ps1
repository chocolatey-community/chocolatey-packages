$ErrorActionPreference = 'Stop'

$version = '2020.4.0-latest-nightly'
$softwareName = "FlightGear v$version"

$packageArgs = @{
  packageName = 'flightgear'
  fileType    = 'exe'
  url         = 'http://download.flightgear.org/builds/nightly/FlightGear-latest-nightly-full.exe'

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
