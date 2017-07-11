$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/13.0.0/mkvtoolnix-32bit-13.0.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/13.0.0/mkvtoolnix-64bit-13.0.0-setup.exe'
  checksum       = '6bb0b73bcde4cea9f7ce80626362ee7898ff7f95a9cad835fe97b5130f219a26'
  checksum64     = 'df9ed99aaa7fff4188fdfd7fdbc9295da73ed26f4dfce84d7d4e8de1ce1ace1f'
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
