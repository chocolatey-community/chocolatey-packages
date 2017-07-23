$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = 'mkvtoolnix'
  fileType       = 'exe'
  url            = 'https://mkvtoolnix.download/windows/releases/14.0.0/mkvtoolnix-32bit-14.0.0-setup.exe'
  url64bit       = 'https://mkvtoolnix.download/windows/releases/14.0.0/mkvtoolnix-64bit-14.0.0-setup.exe'
  checksum       = 'cb66b72944370b03472257a2e4dedbc24d035d46618a5899c06d04369b786296'
  checksum64     = 'e9048902ee60c186d6cafccdeab5ff9b786508697a09189893ecdb15b8a08694'
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
