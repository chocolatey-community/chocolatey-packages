$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'php'

$installLocation = GetInstallLocation -libDirectory "$toolsPath\.."

if ($installLocation) {
  UninstallPackage -libDirectory "$toolsPath\.." -packageName $packageName
  Uninstall-ChocolateyPath -pathToRemove $installLocation
} else {
  Write-Warning "$packageName install path was not found. It may already be uninstalled!"
}
