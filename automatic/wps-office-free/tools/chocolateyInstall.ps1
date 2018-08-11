$ErrorActionPreference = 'Stop'

$version = '10.2.0.745600'
$packageName = 'wps-office-free'
$regName = $packageName -replace('\-',' ')
$regName = $regName -replace('free','*')
$registry = Get-UninstallRegistryKey -SoftwareName $regName
$packageArgs = @{
  packageName    = 'wps-office-free'
  fileType       = 'exe'
  url            = 'https://jump.wps.com/latest_package?distsrc=00100.00000103'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $regName
  checksum       = '302f5d375ca98370f04762775448068057c43ea748afa658fc21f2923663bb89'
  checksumType   = 'sha256'
}

if (($registry.DisplayVersion -ge $version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "The $registry.DisplayVersion is already installed."
} else {
  Install-ChocolateyPackage @packageArgs
}
