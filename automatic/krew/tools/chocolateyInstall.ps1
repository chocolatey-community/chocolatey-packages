$ErrorActionPreference = 'Stop'

$packageName = 'krew'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

Install-BinFile $packageName "$toolsPath\$packageName.exe"
Install-ChocolateyPath "%USERPROFILE%\.krew\bin" Machine
