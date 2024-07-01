$ErrorActionPreference = 'Stop'

# This adds a registry keys which prevent Google Chrome from getting installed together with Piriform software products.
$regDirChrome = 'HKLM:\SOFTWARE\Google\No Chrome Offer Until'
$regDirToolbar = 'HKLM:\SOFTWARE\Google\No Toolbar Offer Until'
if (Get-OSArchitectureWidth 64) {
  $regDirChrome = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
  $regDirToolbar = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
}
& {
  New-Item $regDirChrome -ItemType directory -Force
  New-ItemProperty -Name "Piriform Ltd" -Path $regDirChrome -PropertyType DWORD -Value 20991231 -Force
  New-Item $regDirToolbar -ItemType directory -Force
  New-ItemProperty -Name "Piriform Ltd" -Path $regDirToolbar -PropertyType DWORD -Value 20991231 -Force
} | Out-Null

if ($Env:ChocolateyPackageParameters -match '/UseSystemLocale') {
  Write-Host "Using system locale"
  $locale = "/L=" + (Get-Culture).LCID
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url            = 'https://download.ccleaner.com/ccsetup625.exe'
  checksum       = 'FC742A3D45B0ECAE70740BD66A9A4C01B01ECC239DFB1CFC15A4B0D93ABA6F3D'
  checksumType   = 'sha256'
  silentArgs     = "/S $locale"
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
