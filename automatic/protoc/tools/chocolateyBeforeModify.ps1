Write-Host "Removing protoc shim before upgrading/uninstalling..."

Uninstall-BinFile "protoc" -path "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\bin\protoc.exe"
