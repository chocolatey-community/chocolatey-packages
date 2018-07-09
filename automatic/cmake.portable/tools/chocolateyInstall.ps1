$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsPath\cmake-3.12.0-rc3-win32-x86.zip"
  file64      = "$toolsPath\cmake-3.12.0-rc3-win64-x64.zip"
  destination = $toolsPath
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0
