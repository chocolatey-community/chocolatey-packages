Write-Host "Removing julia shim before upgrading/uninstalling..."

$binFilePath = Get-UninstallRegistryKey -SoftwareName "Julia*" | Select-Object -First 1 -ExpandProperty DisplayIcon
Uninstall-BinFile "julia" -path $binFilePath
