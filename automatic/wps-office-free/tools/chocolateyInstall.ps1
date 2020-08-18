$ErrorActionPreference = 'Stop'

$version = '11.2.0.9635'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.9635/WPSOffice_11.2.0.9635.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '091fda8afcfbffbeb0a59a40bc045d5ac02ab839147855a1d704236a28618256'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
