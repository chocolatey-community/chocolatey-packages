$ErrorActionPreference = 'Stop'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  File        = "$toolsPath\rubyinstaller-2.7.5-1-x86.7z"
  File64      = "$toolsPath\rubyinstaller-2.7.5-1-x64.7z"
  Destination = "$toolsDir\ruby"
  PackageName = $env:ChocolateyPackageName
}

Get-ChocolateyUnzip @packageArgs

Get-ChildItem $toolsPath\*.7z | ForEach-Object { Remove-Item $_ -ea 0 }
