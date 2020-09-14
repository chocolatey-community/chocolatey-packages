$ErrorActionPreference = 'Stop'

$packageName = 'krew'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  Name = $packageName
  Path = "$toolsPath\$packageName.exe"
}

Install-BinFile @packageArgs
