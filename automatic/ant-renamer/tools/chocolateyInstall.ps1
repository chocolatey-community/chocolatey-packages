$ErrorActionPreference = 'Stop'
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs  = @{
  packageName    = $env:chocolateyPackageName
  softwareName   = 'Ant Renamer'
  fileType       = 'exe'
  file           = "$toolsPath\antrenamer2_install.exe"
  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
