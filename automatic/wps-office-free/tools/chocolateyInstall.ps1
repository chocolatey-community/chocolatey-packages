$ErrorActionPreference = 'Stop'

$version = '11.2.0.10152'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.10152/WPSOffice_11.2.0.10152.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = 'c88cc6d11d88d1c5727706cdff0960ba48d3a1b259402353a105177a1b9c0cc8'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
