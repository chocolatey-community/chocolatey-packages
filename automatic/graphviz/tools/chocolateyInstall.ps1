$ErrorActionPreference = 'Stop'

$toolsPath= Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'graphviz'
  fileType       = 'msi'
  file           = gi $toolsPath\*.msi
  silentArgs     = '/Q'
  validExitCodes = @(0)
  softwareName   = 'Graphviz'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.msi
