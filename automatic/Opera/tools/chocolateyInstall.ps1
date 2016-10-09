$ErrorActionPreference = 'Stop'

$packageName = 'Opera'
$url32       = 'http://get.geo.opera.com/pub/opera/desktop/40.0.2308.81/win/Opera_40.0.2308.81_Setup.exe'
$checksum32  = '4496e3ff7d2143fd2781deb0b96e933bebd08ffceae9528adde9bc6a467f3990'
$version     = '40.0.2308.81'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url32
  checksum       = $checksum32
  checksumType   = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

$regPathModifierArray = @('Wow6432Node\', '')
$alreadyInstalled = $null

foreach ($regPathModifier in $regPathModifierArray) {
  $regPath = "HKLM:\SOFTWARE\${regPathModifier}Microsoft\Windows\CurrentVersion\Uninstall\Opera $version"
  if (Test-Path $regPath) {
    $alreadyInstalled = $true
  }
}

if ($alreadyInstalled) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
