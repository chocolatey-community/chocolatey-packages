$ErrorActionPreference = 'Stop'

$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; Remove-Item "$toolsDir\curl_x32" -Recurse; "$toolsDir\curl_x64"
} else { Write-Host "Installing 32 bit version"; Remove-Item "$toolsDir\curl_x64" -Recurse; "$toolsDir\curl_x32" }

Move-Item -Path "$toolsDir\cacert.pem" -Destination "$embedded_path\curl-ca-bundle.crt" -Force
