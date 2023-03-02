$ErrorActionPreference = 'Stop'

$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$filePath32 = "$toolsDir\tx-windows-386.zip"
$filePath64 = "$toolsDir\tx-windows-amd64.zip"

$packageArgs = @{
  packageName = 'transifex-cli'
  destination = $toolsDir
  file        = if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne $true) {
    Write-Host "Installing 64 bit version"
    $filePath64
  }
  else {
    Write-Host "Installing 32 bit version"
    $filePath32
  }
}

Get-ChocolateyUnzip @packageArgs
