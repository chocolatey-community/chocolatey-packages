$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$filePath = "$toolsPath\PyHoca-GUI_0.5.0.4-20150125_win32-setup_x32.exe"

$packageArgs = @{
  packageName    = 'pyhoca-gui'
  fileType       = 'exe'
  file           = $filePath
  softwareName   = 'PyHoca-GUI'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Start-Process 'AutoHotkey' "$toolsPath\install.ahk"
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 $filePath,"$filePath.ignore"
