$ErrorActionPreference = 'Stop';

$packageName   = $env:ChocolateyPackageName
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath   = Get-Item $toolsDir\*_i386.tar.gz
  FileFullPath64 = Get-Item $toolsDir\*_x86_64.gz
  Destination    = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

$packageArgs2 = @{
  PackageName    = $packageName
  FileFullPath   = Get-Item $toolsDir\*_i386.tar
  FileFullPath64 = Get-Item $toolsDir\*_x86_64.tar
  Destination    = $toolsDir
}

Get-ChocolateyUnzip @packageArgs2

Remove-Item "$toolsDir\k9s_Windows_*.tar"