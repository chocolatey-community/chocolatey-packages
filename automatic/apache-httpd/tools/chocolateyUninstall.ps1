$configFile = Join-Path $env:chocolateyPackageFolder 'config.json'
$config = Get-Content $configFile -Raw | ConvertFrom-Json

$service = Get-Service | Where-Object Name -eq $config.serviceName
if ($service) {
    Stop-Service $config.serviceName
}

& $($config.httpdPath) -k uninstall -n "$($config.serviceName)"

Remove-Item $config.installLocation -Recurse -Force
