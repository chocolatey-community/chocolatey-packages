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
  url            = 'https://download.ccleaner.com/ccsetup567.exe'
  checksum       = '5150573d2a9cdc089f1b3905b7d30efd91febf3ffef85abbe920feb7849b1715'
  checksumType   = 'sha256'
  silentArgs     = "/S $locale"
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
