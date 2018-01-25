$ErrorActionPreference = 'Stop'

$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; Remove-Item "$toolsDir\curl_x32" -Recurse
} else { Write-Host "Installing 32 bit version"; Remove-Item "$toolsDir\curl_x64" -Recurse}
