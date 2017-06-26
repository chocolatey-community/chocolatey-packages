$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'git.portable'
    FileFullPath   = $toolsPath\*-32-bit.7z.exe
    FileFullPath64 = $toolsPath\*-64-bit.7z.exe
    Destination    = "$(Get-ToolsLocation)\git"
}
Get-ChocolateyUnzip @packageArgs
Install-ChocolateyPath $packageArgs.Destination

ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { touch "$_.ignore" } }