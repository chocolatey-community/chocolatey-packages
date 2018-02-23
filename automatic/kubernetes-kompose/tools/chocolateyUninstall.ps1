$ErrorActionPreference = 'Stop'

$installLocation = "$(Get-ToolsLocation)\kubernetes-kompose"

Write-Host "Removing Kompose from '$installLocation'"
Remove-Item $installLocation -Recurse -Force -ea 0

$binPath = "$installLocation\bin"
$pathType = [System.EnvironmentVariableTarget]::User

Update-SessionEnvironment
$envPath = $env:PATH
if ($envPath.ToLower().Contains($binPath.ToLower())) {
    $actualPath = Get-EnvironmentVariable -Name 'Path' -Scope $pathType -PreserveVariables

    $statementTerminator = ";"
    $actualPath = $actualPath.Replace("$statementTerminator$binPath", '')

    Set-EnvironmentVariable -Name 'Path' -Value $actualPath -Scope $pathType

    $envPSPath = $env:PATH
    $env:Path = $envPSPath.Replace("$statementTerminator$binPath", '')
}
