$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = 'git.portable'
  FileFullPath   = gi $toolsPath\*-32-bit.7z.exe
  FileFullPath64 = gi $toolsPath\*-64-bit.7z.exe
  Destination    = "$(Get-ToolsLocation)\git"
}
Get-ChocolateyUnzip @packageArgs
Install-ChocolateyPath "$($packageArgs.Destination)\bin"

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" } }
