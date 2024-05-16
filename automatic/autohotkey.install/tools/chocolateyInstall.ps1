$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$installerv1File = 'AutoHotkey_1.1.36.02_setup.exe'
$installerv2File = 'AutoHotkey_2.0.15_setup.exe'

$pp = Get-PackageParameters
if (!$pp.DefaultVer){
  $pp.DefaultVer = if ((Get-OSArchitectureWidth 64) -and ($Env:chocolateyForceX86 -ne 'true')) { 'U64' } else { 'U32' }
}

$packageArgsv2 = @{
  packageName    = 'autohotkey.install'
  fileType       = 'exe'
  file           = Join-Path -Path $toolsDir -ChildPath $installerv2File
  silentArgs     = "/silent"
  softwareName   = 'AutoHotkey*'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgsv2

$installLocation = Get-AppInstallLocation $packageArgsv2.softwareName
$packageName = $packageArgsv2.softwareName
$installName = 'AutoHotkey'
$exePath = Join-Path -Path $installLocation -ChildPath "v2\$installName.exe"
if ($installLocation) {
  Write-Host "$packageName installed to '$installLocation'"
  Register-Application -ExePath $exePath
  Write-Host "$packageName registered as $installName"
}
else {
  Write-Warning "Can't find $packageName install location"
}

$packageArgsv1 = @{
  packageName    = 'autohotkey.install'
  fileType       = 'exe'
  file           = Join-Path -Path $toolsDir -ChildPath $installerv1File
  silentArgs     = "/S /$($pp.DefaultVer) /install"
  softwareName   = 'AutoHotkey*'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgsv1

# This is run to ensure that version 2.x is shown in Programs and Features and registered with the system.
# See https://www.autohotkey.com/docs/v2/Program.htm#install_v1
# The /silent switch was found by looking at the ux\install.ahk script
$ahkInstall = Join-Path -Path $installLocation -ChildPath 'ux\install.ahk'
Start-ChocolateyProcessAsAdmin -ExeToRun $exePath -Statements """$ahkInstall"" /silent"

Remove-Item $toolsDir\*.exe
