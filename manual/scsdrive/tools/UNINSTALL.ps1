$ErrorActionPreference = 'Stop'

$packageName = 'scsdrive'

# The Inno Setup installer registers its own uninstaller, so use that instead of
# running the setup executable again.
$uninstall = Get-UninstallRegistryKey -SoftwareName 'ScsDrive*' | Select-Object -First 1
if (-not $uninstall) {
  throw 'ScsDrive was not found in the uninstall registry.'
}

$uninstallString = $uninstall.UninstallString
$file = ($uninstallString -split '"')[1]
if (-not $file) { $file = ($uninstallString -split ' ')[0] }

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  file           = $file
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
}

Uninstall-ChocolateyPackage @packageArgs
