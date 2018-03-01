$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'x2go'
  fileType       = 'exe'
  file           = "$toolsPath\x2goclient-4.1.1.1-2018.03.01-setup.exe"
  softwareName   = 'X2Go Client*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
