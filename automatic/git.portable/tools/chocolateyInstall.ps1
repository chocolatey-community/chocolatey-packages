$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = 'git.portable'
  file64       = "$toolsPath\PortableGit-2.53.0-64-bit.7z.exe"
  Destination  = "$(Get-ToolsLocation)\git"
}
Get-ChocolateyUnzip @packageArgs
Install-ChocolateyPath "$($packageArgs.Destination)\bin"

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
