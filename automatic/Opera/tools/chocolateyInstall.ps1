$ErrorActionPreference = 'Stop'

$packageName = 'Opera'
$url32       = 'http://get.geo.opera.com/pub/opera/desktop/40.0.2308.90/win/Opera_40.0.2308.90_Setup.exe'
$checksum32  = '9a4df66720ad82ee9721a39171b654e82adf3fe127a208401261d592e9f07286'
$version     = '40.0.2308.90'

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
