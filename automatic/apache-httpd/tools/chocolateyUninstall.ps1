& $($config.httpdPath) -k uninstall -n "$($config.serviceName)"

Remove-Item $config.destination -Recurse -Force
