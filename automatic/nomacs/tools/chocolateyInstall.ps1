$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'nomacs'
  fileType       = 'msi'
  file           = Get-Item $toolsPath\*-x86.msi
  file64         = Get-Item $toolsPath\*-x64.msi
  silentArgs     = '/quiet /norestart /log "{0}/setup.log"' -f (Get-PackageCacheLocation)
  validExitCodes = @(0)
  softwareName   = 'nomacs*'
}
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsPath\*.msi -ea 0
