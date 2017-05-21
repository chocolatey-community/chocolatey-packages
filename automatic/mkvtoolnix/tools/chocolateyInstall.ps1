$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/12.0.0/mkvtoolnix-32bit-12.0.0-setup-1.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/12.0.0/mkvtoolnix-64bit-12.0.0-setup-1.exe'
  checksum       = '3a0850815cf85f0742f8b8c2c687060e80405ae2f7102d83231735f3d4e01b38'
  checksum64     = '2ad930d8b4e8e2640a8829b2a88d19572dea2c6c5576bdff3141e67717a7dc4c'
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
