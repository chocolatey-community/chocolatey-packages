$ErrorActionPreference = 'Stop'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\WinPcap_4_1_3.exe"
$ahkExe        = 'AutoHotKey'
$ahkFile       = "$toolsDir\winpcapInstall.ahk"

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  file         = $url
  silentArgs   = '/S'
  softwareName = "Winpcap"
  }

Start-Process $ahkExe $ahkFile
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url -Force -ErrorAction SilentlyContinue | Out-Null
