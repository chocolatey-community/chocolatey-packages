$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = 'git.portable'
  FileFullPath   = Get-Item $toolsPath\*-32-bit.7z.exe
  FileFullPath64 = Get-Item $toolsPath\*-64-bit.7z.exe
  Destination    = "$(Get-ToolsLocation)\git"
}
Get-ChocolateyUnzip @packageArgs
Install-ChocolateyPath "$($packageArgs.Destination)\bin"

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
