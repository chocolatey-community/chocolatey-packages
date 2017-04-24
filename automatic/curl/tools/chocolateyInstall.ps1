$ErrorActionPreference = 'Stop'

$toolsDir      = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; rm "$toolsDir\curl_x32" -Recurse
} else { Write-Host "Installing 32 bit version"; rm "$toolsDir\curl_x64" -Recurse}
