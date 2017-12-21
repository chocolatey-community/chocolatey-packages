$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  file           = "$toolsPath\seafile-6.1.4-en.msi"
  softwareName   = 'Seafile*'
  silentArgs     = "/passive"
  validExitCodes = @(0, 2010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.msi","$toolsPath\*.ignore"
