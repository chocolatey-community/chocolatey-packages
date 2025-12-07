$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. (Join-Path $toolsDir 'helper.ps1')

$version = '145.0.7567.0-snapshots'
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
  url           = 'https://storage.googleapis.com/chromium-browser-snapshots/Win/1555158/mini_installer.exe'
  checksum      = '4C6D93A2616422461D2C320B6F494660D777F3E5A79F984403D1700E5FA41780'
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
