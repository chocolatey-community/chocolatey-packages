$ErrorActionPreference = 'Stop'

$packageName = 'ccleaner'
$url32       = 'https://download.piriform.com/ccsetup537.exe'
$url64       = $url32
$checksum32  = '54e4512e0bf7c8359b883d814b1a8ba587f67e62f7b07be496fccda79fd75f2d'
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
