$ErrorActionPreference = 'Stop'

$version = '11.2.0.8684'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.8684/WPSOffice_11.2.0.8684_Free.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = 'e576666b78cf03d8be7b7b5fbf3ffb7cb207c16c7349faaad15efb45a4403369'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
