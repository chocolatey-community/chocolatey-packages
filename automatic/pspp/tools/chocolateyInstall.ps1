$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'pspp'
  fileType       = 'exe'
  file           = "$toolsPath\pspp-20170907-daily-32bits-setup.exe"
  file64         = "$toolsPath\pspp-20170907-daily-64bits-setup.exe"
  softwareName   = 'pspp*'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
