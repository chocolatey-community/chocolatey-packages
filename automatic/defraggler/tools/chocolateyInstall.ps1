$ErrorActionPreference = 'Stop'

$packageName = 'defraggler'
$url32       = 'https://download.ccleaner.com/dfsetup222.exe'
$url64       = $url32
$checksum32  = 'b53eb82d6a46c812171ca878b7342e1939a0afecc277b0b57c708eef8fc700de'
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
if (Get-OSArchitectureWidth 64) {
    $regDirChrome  = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
    $regDirToolbar = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
}
& {
    New-Item $regDirChrome -ItemType directory -Force
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirChrome -PropertyType DWORD -Value 20991231 -Force
    New-Item $regDirToolbar -ItemType directory -Force
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirToolbar -PropertyType DWORD -Value 20991231 -Force
} | Out-Null
