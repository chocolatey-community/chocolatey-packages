$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/15.0.0/mkvtoolnix-32-bit-15.0.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/15.0.0/mkvtoolnix-64-bit-15.0.0-setup.exe'
  checksum       = 'c8ca8b9ee03b9da38bd05d18897786b2aafa01cd74061c207b30206080419cfa'
  checksum64     = 'a0363d2bd6be9bb4cff6627f262acefa1e8821b8eaf840fbce3f7e6f540a1ef7'
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
