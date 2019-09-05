$ErrorActionPreference = 'Stop'

$version = '11.2.0.8942'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.8942/WPSOffice_11.2.0.8942.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = 'a8938b376847e31eb30b7c01fc897e2b09a810efd375aa66cb690e10de322d3a'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
