$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'sweet-home-3d'
  fileType       = 'exe'
  file           = "$toolsPath\SweetHome3D-5.6-windows.exe"
  softwareName   = 'Sweet Home 3D*'
  silentArgs     = '/SILENT'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
