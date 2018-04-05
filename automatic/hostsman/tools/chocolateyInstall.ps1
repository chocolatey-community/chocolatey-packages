$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'zip'
  file           = "$toolsPath\"
  softwareName   = 'hostsman*'
}

Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
