$ErrorActionPreference = 'Stop'

# https://github.com/chocolatey-community/chocolatey-coreteampackages/issues/1043
Write-Warning "This software is not maintained any more and could potentially put users at risk."
Write-Warning "Instead, you can use 'gpg4win' or 'gnupg' packages."

Get-Service dirmngr -ea 0 | Stop-Service

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'gpg4win-vanilla'
  fileType       = $fileType
  file           = gi $toolsPath\*.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Gpg4Win *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" '' }}
