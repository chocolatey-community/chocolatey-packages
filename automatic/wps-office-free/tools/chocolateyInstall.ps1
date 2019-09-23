$ErrorActionPreference = 'Stop'

$version = '11.2.0.8970'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.8970/WPSOffice_11.2.0.8970.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '084b73f84cdc2240d7278028e671c4005cd4020f6c70a96e8116446b93ce2459'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
