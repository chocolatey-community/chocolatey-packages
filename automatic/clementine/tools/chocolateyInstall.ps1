$ErrorActionPreference = 'Stop'

$packageName = 'clementine'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = 'https://github.com/clementine-player/Clementine/releases/download/1.3.1/ClementineSetup-1.3.1.exe'
  checksum       = '8ebf4808de874c0fe6a71a5953a3d302cb6348e6ca45dcc268fb4e5c641eddf0'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  {
  Write-Host "$packageName installed to '$installLocation'"
  Register-Application "$installLocation\$packageName.exe"
  Write-Host "$packageName registered as $packageName"
}
else {
  Write-Warning "Can't find $PackageName install location"
}
