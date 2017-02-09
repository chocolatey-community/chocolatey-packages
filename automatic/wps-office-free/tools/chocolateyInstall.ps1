$ErrorActionPreference = 'Stop'

$version = '10.2.0.5820'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'https://jump.wps.com/latest_package?distsrc=00100.00000103&lang=en'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '1F2F28BE2A2E21D2CF0B3FA0E3196D2291470220A28645CADBCC55EECD936C3B'
  checksumType   = 'sha256'
}

if ( $registry.DisplayVersion -ge $version ) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
