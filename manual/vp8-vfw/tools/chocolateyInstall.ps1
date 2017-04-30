$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'vp8-vfw'
  fileType       = 'exe'
  file           = "$toolsPath\vp8vfw-setup-1.2.0.exe"
  softwareName   = 'VP8 Video For Windows codec*'
  silentArgs     = '/SILENT'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
