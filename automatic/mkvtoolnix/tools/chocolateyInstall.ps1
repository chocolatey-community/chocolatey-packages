$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/9.9.0/mkvtoolnix-32bit-9.9.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/9.9.0/mkvtoolnix-64bit-9.9.0-setup.exe'
  checksum       = '5b7861fe75b3f7152f79e716e091ca2abe060e03fe6ca179105dbfe9f067c80f'
  checksum64     = '1e9c1d7eb47791c6c96e3258184227c94de64c637fa0a6e1f1cd259dc7b7ad2a'
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
