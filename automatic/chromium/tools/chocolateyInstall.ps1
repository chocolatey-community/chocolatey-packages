$ErrorActionPreference = 'Stop'

$chromium_string = "\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Chromium"
$hive = "hkcu"
$Chromium = $hive + ":" + $chromium_string

if (Test-Path $Chromium) {
  $silentArgs = '--do-not-launch-chrome'
} else {
  $silentArgs = '--system-level --do-not-launch-chrome'
}

function Get-CompareVersion {
  param(
    [string]$version,
    [string]$notation,
    [string]$package
  )
    $packver = @{$true = $version; $false = ($version -replace($notation,""))}[ ( $version -notmatch $notation ) ]
    [array]$key = Get-UninstallRegistryKey -SoftwareName "$package*"
    if ($packver -eq ( $key.Version )) {
      Write-Host "$package $version is already installed."
      return
    }
  }

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version = "63.0.3239.108"
Get-CompareVersion -version $version -notation "-snapshots" -package "chromium"

$packageArgs = @{
  packageName   = 'chromium'
  file          = "$toolsdir\chromium_x32.exe"
  file64        = "$toolsdir\chromium_x64.exe"
  fileType      = 'exe'
  silentArgs    = $silentArgs
  validExitCodes= @(0)
  softwareName  = 'Chromium'
}

Install-ChocolateyInstallPackage @packageArgs
rm $toolsDir\*.exe -ea 0 -force