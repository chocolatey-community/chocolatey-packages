$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = "$toolsDir\k9s_Windows_amd64.zip"
  Destination    = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

Remove-Item "$toolsDir\k9s_Windows_amd64.zip"
