$ErrorActionPreference = 'Stop'

$version = '11.2.0.8934'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/11.2.0.8934/WPSOffice_11.2.0.8934.exe'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = 'd9df27ea8544197fa84e10afb8cc615e46faef6459ba38b42b03c3aad6b47f55'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
