$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'wixtoolset'
  fileType       = 'exe'
  file           = "$toolsPath\wix311.exe"
  softwareName   = 'WiX Toolset*'
  silentArgs     = '/q'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsDir\*.exe","$toolsDir\*.ignore"
