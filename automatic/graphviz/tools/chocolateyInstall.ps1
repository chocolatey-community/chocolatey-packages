$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'graphviz'
  fileType       = 'msi'
  file           = gi $toolsPath\*.msi
  silentArgs     = '/Q'
  validExitCodes = @(0)
  softwareName   = 'Graphviz'
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsPath\*.msi -ea 0

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Install-BinFile dot $installLocation\bin\dot.exe
