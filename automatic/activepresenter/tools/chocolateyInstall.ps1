$ErrorActionPreference = 'Stop'

$fileType      = 'exe'
$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = Get-Item "$toolsDir\*.$fileType"

$packageArgs = @{
  packageName    = 'activepresenter'
  fileType       = $fileType
  file           = $embedded_path
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $embedded_path -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
