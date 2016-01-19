$scriptPath = Split-Path $script:MyInvocation.MyCommand.Path

Import-Module (Join-Path $scriptPath 'getUninstallString.ps1')

$uninstallString = getUninstallString 'qbittorrent' 'UninstallString'
if ($uninstallString) {
  Uninstall-ChocolateyPackage $packageName 'exe' '/S' $uninstallString
}
