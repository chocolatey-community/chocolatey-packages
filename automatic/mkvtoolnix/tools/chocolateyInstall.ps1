$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/9.6.0/mkvtoolnix-32bit-9.6.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/9.6.0/mkvtoolnix-64bit-9.6.0-setup.exe'
  checksum       = '520e9b435826a7bd941a05e0542ee21632cb5e0ae1884e164c5bab5946363f9a'
  checksum64     = 'c4f99f1fd70d0284dce7c6ac30e9f31ae19f561a80cd2257c1cf442337477c43'
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
