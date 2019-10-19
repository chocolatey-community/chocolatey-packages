$ErrorActionPreference = 'Stop'

# https://github.com/chocolatey-community/chocolatey-coreteampackages/issues/1043
Write-Warning "This software is not maintained any more and could potentially put users at risk."
Write-Warning "Instead, you can use 'gpg4win' or 'gnupg' packages."

Get-Service dirmngr -ea 0 | Stop-Service

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'gpg4win-light'
  fileType       = $fileType
  file           = Get-Item $toolsPath\*.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Gpg4Win *'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' }}
