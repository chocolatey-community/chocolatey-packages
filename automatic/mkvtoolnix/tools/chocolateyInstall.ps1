$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/9.8.0/mkvtoolnix-32bit-9.8.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/9.8.0/mkvtoolnix-64bit-9.8.0-setup.exe'
  checksum       = '422c83db610ab39da255f68718b20753fcf230c74f21c2134a8d28bbbe048587'
  checksum64     = '7908be6abd1141f791d78e62cf47cad0ebc6b572e30d4dcd1da7a65e0fc8828b'
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
