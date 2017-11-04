$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$silentArgs =  '/silent','/sp-','/suppressmsgboxes'
$silentArgs += '/DIR="{0}"' -f $( if ($pp.InstallDir) { $pp.InstallDir } else { "$Env:ProgramFiles\OpenSSL" } )

$packageArgs = @{
  packageName    = 'OpenSSL.Light'
  fileType       = 'exe'
  file           = "$toolsPath\Win32OpenSSL_Light-1_1_0g.exe"
  file64         = "$toolsPath\Win64OpenSSL_Light-1_1_0g.exe"
  softwareName   = 'OpenSSL*Light*'
  silentArgs     = $silentArgs
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location, PATH not updated"; return }
Write-Host "Installed to '$installLocation'"

Install-ChocolateyPath -PathToInstall "$installLocation\bin" -PathType Machine
