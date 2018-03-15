$ErrorActionPreference = 'Stop'

$installLocation = "C:\ProgramData\etcd"

Write-Host "Removing etcd from '$installLocation'"
Remove-Item $installLocation -Recurse -Force -ea 0

$pathType = [System.EnvironmentVariableTarget]::User

Update-SessionEnvironment
$envPath = $env:PATH
if ($envPath.ToLower().Contains($installLocation.ToLower())) {
    $actualPath = Get-EnvironmentVariable -Name 'Path' -Scope $pathType -PreserveVariables

    $statementTerminator = ";"
    $actualPath = $actualPath.Replace("$statementTerminator$installLocation", '')

    Set-EnvironmentVariable -Name 'Path' -Value $actualPath -Scope $pathType

    $envPSPath = $env:PATH
    $env:Path = $envPSPath.Replace("$statementTerminator$installLocation", '')
}
