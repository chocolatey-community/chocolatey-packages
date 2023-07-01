﻿$ErrorActionPreference = 'Stop'

if ((Get-OSArchitectureWidth 32) -or $env:ChocolateyForceX86) {
  throw "32bit installation is no longer supported. Please install version 3.3.6 if this is needed."
}

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$pp = Get-PackageParameters
$toolsLocation = Get-ToolsLocation

#https://github.com/chocolatey-community/chocolatey-coreteampackages/issues/1291
mkdir $toolsLocation -ea 0 | Out-Null

$cygwin_root = (Get-ItemProperty 'HKLM:\SOFTWARE\Cygwin\setup' -ea 0).rootdir
if (!$cygwin_root) {
  $cygwin_root = if ($pp.InstallDir) { $pp.InstallDir } else { "$toolsLocation\cygwin" }
}
else { Write-Host 'Existing installation detected, ignoring InstallDir argument' }

if (!$pp.Proxy) {
  $pp.Proxy = $Env:ChocolateyProxyLocation
  if (!$pp.Proxy) {
    $wc = New-Object System.Net.WebClient; $url = 'https://cygwin.com'
    $pp.Proxy = if (!$wc.Proxy.IsBypassed($url)) { $wc.Proxy.GetProxy($url).Authority }
  }
}

if (!$pp.Site) { $pp.Site = 'http://mirrors.kernel.org/sourceware/cygwin/' }
Write-Host "Download site: $($pp.Site)"

if (!$pp.Packages) { $pp.Packages = 'default' }

$silentArgs = @(
  '--quiet-mode'
  "--site `"$($pp.Site)`""
  "--packages `"$($pp.Packages)`""
  "--root `"$cygwin_root`""
  "--local-package-dir `"$cygwin_root`""

  if (!$pp.DesktopIcon) { '--no-desktop' } else { Write-Host 'Desktop icon will be created' }
  if ($pp.NoStartMenu) { '--no-startmenu'; Write-Host 'No start menu items will be created' }
  if ($pp.Proxy) { "--proxy `"$($pp.Proxy)`""; Write-Host "Using proxy: $($pp.Proxy)" }
  if ($pp.Pubkey) { "--pubkey `"$($pp.Pubkey)`""; Write-Host "URL of extra public key file is provided" }
  if ($pp.NoAdmin) { '--no-admin'; Write-Host "Do not require running as administrator" }
)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = ''
  file64         = "$toolsPath\setup-x86_64.exe"
  softwareName   = 'Cygwin*'
  silentArgs     = $silentArgs
  validExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name "Cygwin" -Path "$cygwin_root\Cygwin.bat"

Write-Host "Copying cygwin package manager (setup) to $cygwin_root"
$setup_path = $packageArgs.file64
Move-Item $setup_path $cygwin_root\cygwinsetup.exe -Force

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" "" }}
