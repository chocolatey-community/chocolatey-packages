$ErrorActionPreference = 'Stop'

$installLocation = "$(Get-ToolsLocation)\kubernetes-cli"

Write-Host "Removing Kubernetes client from '$installLocation'"
Remove-Item $installLocation -Recurse -Force -ea 0

$newPath = $Env:Path.Replace(";$installLocation\bin", '')
if ($newPath -eq $Env:PATH) { return }
