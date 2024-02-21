$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$tcExeName = 'totalcmd.exe'
. $toolsPath\helpers.ps1

# Total Commander install switches
# https://www.ghisler.ch/wiki/index.php?title=Installer#Description_of_switches_and_parameters
$pp = Get-PackageParameters

# Add a desktop icon
$installArgs = '/A1H1U1G1'
if ($pp['NoDesktopIcon']) {
  $installArgs += 'D0'
}
else {
  $installArgs += 'D1'
}

# Installation path - this must be last
if ($pp.InstallPath) {
  $installArgs += " $($pp.InstallPath)"
}

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'
    file           = "$toolsPath\tcmd1103x32_64.exe"
    silentArgs     = $installArgs
    validExitCodes = @(0)
    softwareName   = 'Total Commander*'
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Path "$toolsPath\*.exe" -ErrorAction SilentlyContinue

$packageName = $env:ChocolateyPackageName
$installLocation = Get-TCInstallLocation
if (-not $installLocation)  {
  Write-Warning "Can't find $packageName install location"
  return
}
else {
  Write-Host "$packageName installed to '$installLocation'"
}

Write-Host 'Setting system environment COMMANDER_PATH'
Set-EnvironmentVariable -Name 'COMMANDER_PATH' -Value $installLocation -Scope Machine

if ($pp.ShellExtension) {
  Set-TCShellExtension
}

if ($pp['DefaultFM'] -and $pp['ResetDefaultFM']) {
  Write-Warning 'You have provided both the /DefaultFM and /ResetDefaultFM switches which are contradictory. Will not use either.'
}
else {
  if ($pp['ResetDefaultFM'] -eq $true) {
    Set-ExplorerAsDefaultFM
  }
  elseif ($pp['DefaultFM'] -eq $true) {
    Set-TCAsDefaultFM
  }
}

Register-Application -ExePath "$installLocation\$tcExeName" -Name 'tc'
Write-Host "$packageName registered as tc"
