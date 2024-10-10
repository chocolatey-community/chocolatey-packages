$ErrorActionPreference = 'Stop'

$version = '2020.3.19'
$softwareName = "FlightGear v$version"

$packageArgs = @{
  packageName = 'flightgear'
  fileType    = 'exe'
  url         = 'https://sourceforge.net/projects/flightgear/files/release-2020.3/FlightGear-2020.3.19.exe/download'

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
