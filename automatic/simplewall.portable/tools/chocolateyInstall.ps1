$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsDir\simplewall-2.3.8-bin.zip"
  destination = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

Remove-Item $toolsDir\*.zip -ea 0
