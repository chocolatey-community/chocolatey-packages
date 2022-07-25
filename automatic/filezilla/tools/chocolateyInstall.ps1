$ErrorActionPreference = 'Stop'

$toolsPath      = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'filezilla'
  fileType       = $fileType
  file           = Get-Item $toolsPath\*_x32.exe
  file64         = Get-Item $toolsPath\*_x64.exe
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
  softwareName   = 'FileZilla 3*'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content -Value "" -Path "$_.ignore" }}
