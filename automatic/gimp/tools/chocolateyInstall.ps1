$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName    = 'gimp'
  fileType       = 'exe'
  softwareName   = 'GIMP'

  checksum       = '4ad9ab85c969093810d4932b9574d9d82e0527263bcf37a042de1503c36111da'
  checksum64     = '4ad9ab85c969093810d4932b9574d9d82e0527263bcf37a042de1503c36111da'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'

  # The installer contains both 32-bit and 64-bit versions of GIMP, and will automatically use the appropriate one.
  # Text quoted from <https://www.gimp.org/downloads/>, look below download buttons.
  url            = 'https://download.gimp.org/mirror/pub/gimp/v2.8/windows/gimp-2.8.20-setup.exe'
  url64bit       = 'https://download.gimp.org/mirror/pub/gimp/v2.8/windows/gimp-2.8.20-setup.exe'

  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}
$version = '2.8.20'
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
