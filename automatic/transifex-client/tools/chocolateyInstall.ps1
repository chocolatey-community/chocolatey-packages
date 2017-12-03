$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$64bitExec = "$toolsPath\tx.py35.x64.exe"
$destination = "$toolsPath\tx.exe"

if (Test-Path $destination) { Remove-Item -Force $destination }

if ((Get-ProcessorBits 32) -or ($env:chocolateyForceX86 -eq $true)) {
  throw "32bit installation of the transifex-client package is not supported."
}
else {
  Move-Item -Force $64bitExec $destination
  Remove-Item -Force $32bitExec
}
