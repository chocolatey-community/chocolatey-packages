$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $Env:ChocolateyPackageName
  FileFullPath   = "$toolsPath\TO-BE-REPLACED"
  FileFullPath64 = "$toolsPath\TO-BE-REPLACED"
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

Install-BinFile 'protoc' "$toolsPath\bin\protoc.exe"
