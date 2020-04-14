$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsPath\BraveBrowserStandaloneSilentSetup32.exe"
  file64      = "$toolsPath\BraveBrowserStandaloneSilentSetup.exe"
}

[version]$softwareVersion = '1.7.92'

Write-Host "Checking already installed version..."
$installedVersion = Get-InstalledVersion

if ($installedVersion -and ($softwareVersion -lt $installedVersion)) {
  Write-Warning "Skipping installation because a later version than $softwareVersion is installed."
}
elseif ($installedVersion -and ($softwareVersion -eq $installedVersion)) {
  Write-Warning "Skipping installation because version $softwareVersion is already installed."
}
else {
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $toolsPath\*.exe -ea 0
