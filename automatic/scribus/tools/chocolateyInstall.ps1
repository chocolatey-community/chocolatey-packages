$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'scribus'
  fileType       = 'exe'
  file           = "$toolsPath\scribus-1.4.6-windows.exe"
  file64         = "$toolsPath\scribus-1.4.6-windows-x64.exe"
  softwareName   = 'Scribus*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
