﻿$ErrorActionPreference = 'Stop'

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
  url            = 'https://download.ccleaner.com/ccsetup605.exe'
  checksum       = '08031CAE113CF7ABA12DCFAFCF482604015C67D2050233064E1C7827F8014BA2'
  checksumType   = 'sha256'
  silentArgs     = "/S $locale"
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
