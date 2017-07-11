$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'bluefish'
  fileType      = 'exe'
  softwareName  = 'Bluefish*'
  file          = "$toolsPath\Bluefish-2.2.10-setup.exe"
  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
