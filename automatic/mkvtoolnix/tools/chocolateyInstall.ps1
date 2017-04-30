$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/11.0.0/mkvtoolnix-32bit-11.0.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/11.0.0/mkvtoolnix-64bit-11.0.0-setup.exe'
  checksum       = '95e3efcfca0de07e0d08ceeb26744d0a4cafbe9cf14bea328eca1f689b205220'
  checksum64     = '8f7176518fb24e8af7152357cd2212555b54f3c9502fd3233da5c3b5eb723d7e'
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
