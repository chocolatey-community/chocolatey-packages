$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $Env:ChocolateyPackageName
  FileFullPath   = "$toolsPath\protoc-3.11.4-win32.zip"
  FileFullPath64 = "$toolsPath\protoc-3.11.4-win64.zip"
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

Install-BinFile 'protoc' "$toolsPath\bin\protoc.exe"
