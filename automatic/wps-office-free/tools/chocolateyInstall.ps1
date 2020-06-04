$ErrorActionPreference = 'Stop'

$version = '11.2.0.9396'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.9396/WPSOffice_11.2.0.9396.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '7e31c48c737fed8eee2d9cdece7c3a1f8d5ec8d2dcadce807464ec11bd6db5fb'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
