$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

if (Is32BitInstalled) { $env:ChocolateyForceX86 = $true }

$version     = '46.0.2597.26'
$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.26/win/Opera_46.0.2597.26_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera/desktop/46.0.2597.26/win/Opera_46.0.2597.26_Setup_x64.exe'
  checksum       = 'f536dadef999707ee6f0ab5460b7464e6b1c28c7013d429baf34ed5d6f1e570f'
  checksum64     = '769cc21e48b437b0526a17ab214b63274d904858ca0c82e32342a7e562f8c5f6'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0'
  validExitCodes = @(0)
}

if (IsVersionAlreadyInstalled $version) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
