$ErrorActionPreference = 'Stop'

$packageName = 'ccleaner'
$url32       = 'https://download.piriform.com/ccsetup531.exe'
$url64       = $url32
$checksum32  = 'c0ea5b0a8c1f2f1bf0eed8e688ea60fc48f6f953f46e7df40bc26cb8de4585f3'
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
