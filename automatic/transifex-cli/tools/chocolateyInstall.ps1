$ErrorActionPreference = 'Stop'

$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  destination = $toolsDir
  file        = "$toolsDir\tx-windows-386.zip"
  file64      = "$toolsDir\tx-windows-amd64.zip"
}

Get-ChocolateyUnzip @packageArgs
