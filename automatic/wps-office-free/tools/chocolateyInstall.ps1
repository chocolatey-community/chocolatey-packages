$ErrorActionPreference = 'Stop'

$version = '11.2.0.9984'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.9984/WPSOffice_11.2.0.9984.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '5edb7bb48d46ed2790eb7340a7f880345bb64053a235ec296d83c6336e674ce7'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
