$ErrorActionPreference = 'Stop'

$installLocation = Join-Path $(Get-ToolsLocation) 'git'

Write-Host "Removing Git from the '$installLocation'"
Remove-Item $installLocation -Recurse -Force -ea 0

$newPath = $Env:Path.Replace(";$installLocation", '')
if ($newPath -eq $Env:PATH) { return }
Write-Host "Removing Git from system PATH"
[System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')