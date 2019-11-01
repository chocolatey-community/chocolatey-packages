$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsDir\simplewall-3.0.7-bin.zip"
  destination = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

Remove-Item $toolsDir\*.zip -ea 0
