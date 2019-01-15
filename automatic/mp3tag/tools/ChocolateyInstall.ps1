$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$iniFile = Join-Path $toolsPath 'Mp3tagSetup.ini'

$desktop = if ($pp.NoDesktopShortcut) { 0 } else { 1 }
$explorer = if ($pp.NoContextMenu) { 0 } else { 1 }
# Automatic language selection
$LCID = (Get-Culture).LCID
$iniContent = @"
[shortcuts]
startmenu=1
desktop=$desktop
explorer=$explorer

[language]
language=$LCID
"@

# Create the ini file for the installer
New-Item $iniFile -type file -force -value $iniContent

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\"
  silentArgs     = "/S"
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
