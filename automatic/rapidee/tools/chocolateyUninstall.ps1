$ErrorActionPreference = 'Stop'

$startMenu = [Environment]::GetFolderPath("CommonPrograms")
$startMenuLink = Join-Path $startMenu "Rapid Environment Editor.lnk"
Remove-Item "$startMenuLink" -ea 0
