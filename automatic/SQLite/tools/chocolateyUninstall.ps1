$ErrorActionPreference = 'Stop'

$packageName = 'sqlite'
$instDir     = "$(Get-ToolsLocation)\$packageName"

Write-Host "Removing $packageName from the '$instDir'"
rm $instDir -Recurse -Force -ea 0

$new_path = $Env:Path.Replace(";$instDir", '')
if ($new_path -eq $Env:PATH) { return }
Write-Host "Removing $packageName from system PATH"
[System.Environment]::SetEnvironmentVariable('PATH', $new_path, 'Machine')
