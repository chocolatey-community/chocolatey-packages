$configFile = Join-Path $env:chocolateyPackageFolder 'config.json'
$config = Get-Content $configFile -Raw | Out-String | ConvertFrom-Json

& $($config.httpdPath) -k uninstall -n "$($config.serviceName)"

Remove-Item $config.destination -Recurse -Force
