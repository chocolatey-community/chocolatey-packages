$ErrorActionPreference = 'Stop'

$packageName = 'ccleaner'
$url32       = 'https://download.piriform.com/ccsetup538.exe'
$url64       = $url32
$checksum32  = 'e28d4eb40c69b7457d72a1ebef1d8ed41f9e087800d02074d1742c83d584453c'
$checksum64  = $checksum32

if ($Env:ChocolateyPackageParameters -match '/UseSystemLocale') {
    Write-Host "Using system locale"
    $locale = "/L=" + (Get-Culture).LCID 
}

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/S $locale"
  validExitCodes         = @(0)
}
Install-ChocolateyPackage @packageArgs

# This adds a registry keys which prevent Google Chrome from getting installed together with Piriform software products.
$regDirChrome    = 'HKLM:\SOFTWARE\Google\No Chrome Offer Until'
$regDirToolbar   = 'HKLM:\SOFTWARE\Google\No Toolbar Offer Until'
if (Get-ProcessorBits 64) {
    $regDirChrome  = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
    $regDirToolbar = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
}
& {
    New-Item $regDirChrome -ItemType directory -Force
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirChrome -PropertyType DWORD -Value 20991231 -Force
    New-Item $regDirToolbar -ItemType directory -Force
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirToolbar -PropertyType DWORD -Value 20991231 -Force
} | Out-Null
