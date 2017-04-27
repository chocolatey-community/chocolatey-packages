$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'svg-explorer-extension'
  fileType       = 'exe'
  file           = "$toolsPath\dssee_setup_i386_v011_signed.exe"
  file64         = "$toolsPath\dssee_setup_x64_v011_signed.exe"
  softwareName   = 'SVG Explorer Extension*'
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
