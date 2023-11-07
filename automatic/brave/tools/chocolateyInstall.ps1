$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  url         = 'https://github.com/brave/brave-browser/releases/download/v1.61.67/BraveBrowserStandaloneSilentBetaSetup32.exe'
  checksum    = '4C3ACD09F173E151C856A0EEBD932B57BC17EB9BA5BF2DEE9E33FEE604B509BB'
  checksumType= 'sha256'
  file64      = "$toolsPath\BraveBrowserStandaloneSilentBetaSetup.exe"
}

[version]$softwareVersion = '1.61.67'

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
