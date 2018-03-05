$ErrorActionPreference = 'Stop'

$packageName = 'kubernetes-cli'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath   = Get-Item $toolsPath\*-386.tar.gz
  FileFullPath64 = Get-Item $toolsPath\*-amd64.tar.gz
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs

if (Test-Path "$toolsPath\kubernetes*.tar") {
  $packageArgs2 = @{
    PackageName    = $packageName
    FileFullPath   = Get-Item $toolsPath\*-386.tar
    FileFullPath64 = Get-Item $toolsPath\*-amd64.tar
    Destination    = $toolsPath
  }
  Get-ChocolateyUnzip @packageArgs2

  Remove-Item "$toolsPath\kubernetes*.tar"
}
