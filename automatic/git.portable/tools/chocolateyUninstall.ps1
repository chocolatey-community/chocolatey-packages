$ErrorActionPreference = 'Stop'

$installLocation = Join-Path $(Get-ToolsLocation) 'git'

Write-Host "Removing Git from the '$installLocation'"
Remove-Item $installLocation -Recurse -Force -ea 0

$newPath = $Env:Path.Replace(";$installLocation\bin", '')
if ($newPath -eq $Env:PATH) { return }
# If the package was installed in non-admin mode
# we probably won't ever get here
Write-Host "Removing Git from system PATH"
[System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'Machine')
