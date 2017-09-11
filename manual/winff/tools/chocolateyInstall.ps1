$ErrorActionPreference = 'Stop'

$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'winff'
  fileType       = 'exe'
  file           = gi $toolsPath\*exe
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
  softwareName   = 'WinFF *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { touch "$_.ignore" }}
