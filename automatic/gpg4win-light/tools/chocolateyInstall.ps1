$ErrorActionPreference = 'Stop'

Get-Service dirmngr -ea 0 | Stop-Service

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'gpg4win-light'
  fileType       = $fileType
  file           = gi $toolsPath\*.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Gpg4Win *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}
