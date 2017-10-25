$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/17.0.0/mkvtoolnix-32-bit-17.0.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/17.0.0/mkvtoolnix-64-bit-17.0.0-setup.exe'
  checksum       = '6c36699de2b22e50794baa3d91eb8acf5140b80d2f3d7f89ec36f100635db74c'
  checksum64     = 'd82078d72cb67f15889d912a0c432eefc4cd97d1725948d5a5f6628ebc6156a6'
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
