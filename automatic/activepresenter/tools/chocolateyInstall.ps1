$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'activepresenter'
  fileType       = 'exe'
  file           = "$toolsDir\ActivePresenter_v9.1.4_setup.exe"
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs
Remove-Item "$toolsDir\*.exe" -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
