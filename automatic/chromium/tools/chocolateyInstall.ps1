$ErrorActionPreference = 'Stop'

$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
$hive = "hkcu"
$Chromium = $hive + ":" + $chromium_string

if (Test-Path $Chromium) {
  $silentArgs = '--do-not-launch-chrome'
} else {
  $silentArgs = '--system-level --do-not-launch-chrome'
}


$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'chromium'
  file          = "$toolsdir\chromium-sync_x32.exe"
  file64        = "$toolsdir\chromium-sync_x64.exe"
  fileType      = 'exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
}

Install-ChocolateyInstallPackage @packageArgs
