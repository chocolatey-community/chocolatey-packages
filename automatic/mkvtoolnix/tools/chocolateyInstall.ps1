$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/16.0.0/mkvtoolnix-32-bit-16.0.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/16.0.0/mkvtoolnix-64-bit-16.0.0-setup.exe'
  checksum       = 'c5e3ccea3615ad7175d7ab4f62bca0ca5d29eac8904f9e38b61aae32688cd026'
  checksum64     = '1ee3b0503f39c114b823145fea23c1809b2e79dbf7e0b97001859bc69e764ce9'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'mkvtoolnix*'
}

Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $PackageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Write-Host 'Adding to PATH if needed'
Install-ChocolateyPath "$installLocation"       #TODO: Uninstall-ChocolateyPath #310nstall-ChocolateyPackage @packageArgs
