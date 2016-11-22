$ErrorActionPreference = 'Stop'

$packageName = 'Opera'
$url32       = 'http://get.geo.opera.com/pub/opera/desktop/41.0.2353.69/win/Opera_41.0.2353.69_Setup.exe'
$checksum32  = '4b4307742aba09851f77f73e05511e1bbcfaf74db402f4448d86206b12bb91d3'
$version     = '41.0.2353.69'

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
