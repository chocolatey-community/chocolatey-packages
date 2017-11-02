$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$32bitExec = "$toolsPath\tx-32.exe"
$64bitExec = "$toolsPath\tx-64.exe"
$destination = "$toolsPath\tx.exe"

if (Test-Path $destination) { Remove-Item -Force $destination }

if ((Get-ProcessorBits 32) -or ($env:chocolateyForceX86 -eq $true)) {
  Move-Item -Force $32bitExec $destination
  Remove-Item -Force $64bitExec
} else {
  Move-Item -Force $64bitExec $destination
  Remove-Item -Force $32bitExec
}
