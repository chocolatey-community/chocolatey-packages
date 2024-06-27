$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. (Join-Path $toolsDir 'helper.ps1')

$version = '128.0.6562.0-snapshots'
$hive = "hkcu"
$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
$Chromium = $hive + ":" + $chromium_string

if (Test-Path $Chromium) {
  $silentArgs = '--do-not-launch-chrome'
} else {
  $silentArgs = '--system-level --do-not-launch-chrome'
}

$packageArgs = @{
  packageName   = 'chromium'
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/1320203/mini_installer.exe'
  checksum      = '6F7190DF48099F799C94884D865BB20E20C35465E9C5B0D3E1D2EA6CE7D0B0AC'
  checksumType  = 'sha256'
  file64        = "$toolsdir\chromium_x64.exe"
  fileType      = 'exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
}
if (Get-CompareVersion -version $version -notation "-snapshots" -package "chromium") {
  if ((Get-OSArchitectureWidth 32) -or $env:ChocolateyForceX86) {
    Install-ChocolateyPackage @packageArgs
  } else {
    Install-ChocolateyInstallPackage @packageArgs
  }
} else {
  Write-Host "Chromium $version is already installed."
}
# Detritus Package Cleanup
$detritus = @("exe","tmp","ignore")
foreach ( $type in $detritus ) {
	if ( $type -eq "tmp" ) {
		Remove-Item "$toolsDir\*.${type}" -ea 0 -Force -Recurse
	} else {
		Remove-Item "$toolsDir\*.${type}" -ea 0 -force
	}
}
