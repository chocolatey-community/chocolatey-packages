$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsPath\BraveBrowserStandaloneSilentSetup32.exe"
  file64      = "$toolsPath\BraveBrowserStandaloneSilentSetup.exe"
}

if ($alreadyInstalled -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "Skipping installation because version $alreadyInstalled is already installed."
} else {
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $toolsPath\*.exe -ea 0