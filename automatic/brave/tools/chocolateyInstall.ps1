$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  url         = 'https://github.com/brave/brave-browser/releases/download/v1.98.62/BraveBrowserStandaloneSilentSetup32.exe'
  checksum    = 'C63A9DF9CF822C22FDAB552DCADBD45F3585018CC60DF5DC3CDF968896C24E69'
  checksumType= 'sha256'
  file64      = "$toolsPath\BraveBrowserStandaloneSilentSetup.exe"
}

[version]$softwareVersion = '1.98.62'

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
