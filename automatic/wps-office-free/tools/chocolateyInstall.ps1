$ErrorActionPreference = 'Stop'

$version = '11.2.0.10132'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.10132/WPSOffice_11.2.0.10132.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '275c00827a476ca3952a36b1942b9da32dcf0b94a7e59b162d2cd8cfc6e73844'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
