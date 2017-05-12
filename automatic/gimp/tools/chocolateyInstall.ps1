$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'gimp'
  fileType       = 'exe'
  softwareName   = 'GIMP'

  checksum       = 'a2e52129a28feec1ee3f22f5aaf9bdecbb02d51af6da408ace0a2ac2e0365c8b'
  checksum64     = 'a2e52129a28feec1ee3f22f5aaf9bdecbb02d51af6da408ace0a2ac2e0365c8b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'

  # The installer contains both 32-bit and 64-bit versions of GIMP, and will automatically use the appropriate one.
  # Text quoted from <https://www.gimp.org/downloads/>, look below download buttons.
  url            = 'https://download.gimp.org/mirror/pub/gimp/v2.8/windows/gimp-2.8.22-setup.exe'
  url64bit       = 'https://download.gimp.org/mirror/pub/gimp/v2.8/windows/gimp-2.8.22-setup.exe'

  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}
$version = '2.8.22'
$gimpRegistryPath = $(
  'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\GIMP-2_is1'
)

if (Test-Path $gimpRegistryPath) {
  $installedVersion = (
    Get-ItemProperty -Path $gimpRegistryPath -Name 'DisplayVersion'
  ).DisplayVersion
}

if ($installedVersion -eq $version) {
  Write-Output $(
    "GIMP $installedVersion is already installed. " +
    "Skipping download and installation."
  )
} else {
  Install-ChocolateyPackage @packageArgs
}
