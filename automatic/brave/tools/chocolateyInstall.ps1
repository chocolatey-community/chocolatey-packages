$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  url         = 'https://github.com/brave/brave-browser/releases/download/v1.91.171/BraveBrowserStandaloneSilentSetup32.exe'
  checksum    = '401AFF780C13FDBFEE46DBA6058E5CCB18F50B66A8EC7A021914368206B15BAF'
  checksumType= 'sha256'
  file64      = "$toolsPath\BraveBrowserStandaloneSilentSetup.exe"
}

[version]$softwareVersion = '1.91.171'

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
