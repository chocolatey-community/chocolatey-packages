$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1
$is64 = (Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true'

if (!$is64) {
  throw 'Installation of 32-bit version is no longer supported by this package.'
}

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file64      = "$toolsPath\BraveBrowserStandaloneSilentSetup.exe"
}

[version]$softwareVersion = '1.48.171'

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
