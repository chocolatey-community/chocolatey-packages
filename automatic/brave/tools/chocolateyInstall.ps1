$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsDir\BraveBrowserSilentBetaSetup32.exe"
  file64      = "$toolsDir\BraveBrowserSilentBetaSetup.exe"
}

Write-Host "Checking already installed version..."
CheckInstalledVersion

if ($alreadyInstalled -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "Skipping installation because version $alreadyInstalled is already installed."
} else {
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $toolsPath\*.exe -ea 0
