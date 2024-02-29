$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  url         = 'https://github.com/brave/brave-browser/releases/download/v1.64.90/BraveBrowserStandaloneSilentBetaSetup32.exe'
  checksum    = '6ABD1DAFC0F7344BF172ABA5C8D9D94F9C399383C57D1FB2C0C505B37AC754EA'
  checksumType= 'sha256'
  file64      = "$toolsPath\BraveBrowserStandaloneSilentBetaSetup.exe"
}

[version]$softwareVersion = '1.64.90'

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
