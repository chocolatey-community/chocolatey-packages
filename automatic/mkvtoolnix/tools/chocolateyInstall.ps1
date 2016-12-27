$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/9.7.0/mkvtoolnix-32bit-9.7.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/9.7.0/mkvtoolnix-64bit-9.7.0-setup.exe'
  checksum       = '45d570aa96ff857d477e1d9d88aeadbfb2149e1a861ac552aa3a75f5ede4e11d'
  checksum64     = 'db8b8d83136dc69e0a0fabb2b435da306ecd01a220a3778f952df75dbd9b191d'
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
