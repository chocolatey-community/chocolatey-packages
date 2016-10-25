$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'gimp'
  fileType       = 'exe'
  softwareName   = 'GIMP'

  checksum       = '41e98ef75c2992acc9b481147bf3db35652a4c7e1da70bb06a2d2ec9a0853a2d'
  checksum64     = '41e98ef75c2992acc9b481147bf3db35652a4c7e1da70bb06a2d2ec9a0853a2d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  url            = 'https://download.gimp.org/mirror/pub/gimp/v2.8/windows/gimp-2.8.18-setup.exe'
  url64bit       = 'https://download.gimp.org/mirror/pub/gimp/v2.8/windows/gimp-2.8.18-setup.exe'

  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}
$version = '2.8.18'
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
