$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'OpenSSL.Light'
  fileType       = 'exe'
  file           = "$toolsPath\Win32OpenSSL_Light-1_1_0e.exe"
  file64         = "$toolsPath\Win64OpenSSL_Light-1_1_0e.exe"
  softwareName   = ''
  silentArgs     = '/silent'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
