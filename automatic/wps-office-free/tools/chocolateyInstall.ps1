$ErrorActionPreference = 'Stop'

$version = '11.2.0.8641'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.8641/WPSOffice_11.2.0.8641_Free.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '2843f8704688f13226834e8a0302bf3cd4921fb15a28c37e41e02f4b22d7adbb'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
