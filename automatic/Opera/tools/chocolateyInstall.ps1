$ErrorActionPreference = 'Stop'

$packageName = 'Opera'
$url32       = 'http://get.geo.opera.com/pub/opera/desktop/43.0.2442.806/win/Opera_43.0.2442.806_Setup.exe'
$checksum32  = 'd9ff04df950464bb3357dad2337972e699fa2243775105c7f5a6c21a85326e52'
$version     = '43.0.2442.806'

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
