$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$file = ''
$file64 = ''

$packageArgs = @{
  packageName    = ''
  fileType       = ''
  file           = "$toolsPath\$file"
  file64         = "$toolsPath\$file64"
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = ''
}

Install-ChocolateyPackage @packageArgs
Remove-Item $toolsPath\*.exe -ea 0
