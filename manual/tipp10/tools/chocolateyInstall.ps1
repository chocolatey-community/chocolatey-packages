$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'tipp10'
  fileType       = 'exe'
  softwareName   = 'Tipp10*'
  file           = "$toolsPath\tipp10.exe"
  silentArgs     = '/SILENT /NORESTART /SP- /SUPPRESSMSGBOXES'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $packageArgs.file -Force -ea 0
