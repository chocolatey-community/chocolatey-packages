$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'nmap'
  fileType       = 'exe'
  file           = "$toolsDir\nmap-7.60-setup.exe"
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
rm $embedded_path -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { Write-Warning "Can't find $PackageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"
