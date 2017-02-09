$ErrorActionPreference = 'Stop'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageName = 'php'

$installLocation = GetInstallLocation -libDirectory "$toolsPath\.."

if ($installLocation) {
  UninstallPackage -libDirectory "$toolsPath\.." -packageName $packageName

  $di = Get-ChildItem $installLocation -ea 0 | Measure-Object
  if ($di.Count -eq 0) {
    Remove-Item -Force -ea 0 $installLocation
  }

  Uninstall-ChocolateyPath $installLocation

} else {
  Write-Warning "$packageName install path was not found. It may already be uninstalled!"
}
