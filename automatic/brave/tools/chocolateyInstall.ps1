$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  url         = 'https://github.com/brave/brave-browser/releases/download/v1.52.129/BraveBrowserStandaloneSilentSetup32.exe'
  checksum    = '4C5F3DC5F1E2462388746D5A24B0C42C101B559E42B5A0C44C700D89EAB9A994'
  checksumType= 'sha256'
  file64      = "$toolsPath\BraveBrowserStandaloneSilentSetup.exe"
}

[version]$softwareVersion = '1.52.129'

Write-Host "Checking already installed version..."
$installedVersion = Get-InstalledVersion

if ($installedVersion -and ($softwareVersion -lt $installedVersion)) {
  Write-Warning "Skipping installation because a later version than $softwareVersion is installed."
}
elseif ($installedVersion -and ($softwareVersion -eq $installedVersion)) {
  Write-Warning "Skipping installation because version $softwareVersion is already installed."
}
elseif ((Get-OSArchitectureWidth -compare 32) -or ($env:ChocolateyForceX86 -eq $true)) {
  Install-ChocolateyPackage @packageArgs
} else {
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $toolsPath\*.exe -ea 0
