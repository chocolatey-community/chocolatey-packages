﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $Env:ChocolateyPackageName
  FileFullPath   = "$toolsPath\protoc-28.2-win32.zip"
  FileFullPath64 = "$toolsPath\protoc-28.2-win64.zip"
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0
