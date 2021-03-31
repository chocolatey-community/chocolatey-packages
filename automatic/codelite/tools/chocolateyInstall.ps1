$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'codelite'
  fileType       = 'exe'
  file           = "$toolsPath\"
  file64         = "$toolsPath\"
  silentArgs     = '/VERYSILENT /SP- /SUPPRESSMSGBOXES'
  validExitCodes = @(0)
  softwareName   = 'CodeLite'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" } }
