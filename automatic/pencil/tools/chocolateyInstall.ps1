$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $Env:ChocolateyPackageName
  fileType       = 'exe'
  file           = Get-Item $toolsPath\Pencil-*.exe
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'Pencil*'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}
