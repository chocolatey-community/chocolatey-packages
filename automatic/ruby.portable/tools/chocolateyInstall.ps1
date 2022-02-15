$ErrorActionPreference = 'Stop'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  File        = "$toolsPath\"
  File64      = "$toolsPath\"
  Destination = "$toolsDir\ruby"
  PackageName = $env:ChocolateyPackageName
}

Get-ChocolateyUnzip @packageArgs

Get-ChildItem $toolsPath\*.7z | ForEach-Object { Remove-Item $_ -ea 0 }
