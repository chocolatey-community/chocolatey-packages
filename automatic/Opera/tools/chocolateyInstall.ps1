$ErrorActionPreference = 'Stop'

$packageName = 'Opera'
$url32       = 'http://get.geo.opera.com/pub/opera/desktop/42.0.2393.94/win/Opera_42.0.2393.94_Setup.exe'
$checksum32  = 'ef6afaeea15640b7bdbd064d00d2e2608346f0c10361c0f4a053f66673a85359'
$version     = '42.0.2393.94'

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
