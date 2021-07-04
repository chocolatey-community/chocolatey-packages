$ErrorActionPreference = 'Stop'

$packageName = 'minishift'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

Remove-Item "$toolsPath\minishift-*-windows-amd64" -Recurse -Force -ea 0

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\minishift-*-windows-amd64.zip
  Destination    = $toolsPath
}

Get-ChocolateyUnzip @packageArgs
