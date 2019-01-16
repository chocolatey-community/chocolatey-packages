Write-Host "Removing julia shim before upgrading/uninstalling..."

$binFilePath = Get-UninstallRegistryKey -SoftwareName "Julia*" | select -First 1 -ExpandProperty DisplayIcon
Uninstall-BinFile "julia" -path $binFilePath
