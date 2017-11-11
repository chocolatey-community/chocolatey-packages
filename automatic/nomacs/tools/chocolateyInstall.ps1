$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'nomacs'
  fileType       = 'msi'
  file           = gi $toolsPath\*-x86.msi
  file64         = gi $toolsPath\*-x64.msi
  silentArgs     = '/quiet /norestart /log "{0}/setup.log"' -f (Get-PackageCacheLocation)
  validExitCodes = @(0)
  softwareName   = 'nomacs*'
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsPath\*.msi -ea 0
