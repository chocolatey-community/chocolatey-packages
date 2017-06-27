$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$silentArgs = '/silent','/sp-','/suppressmsgboxes'

if ($pp.InstallDir) {
  $dir = $pp.InstallDir 
}
else {
  $dir = "$($env:ProgramFiles)\OpenSSL"
}

$silentArgs += @("/DIR=`"$dir`"")

$packageArgs = @{
  packageName    = 'OpenSSL.Light'
  fileType       = 'exe'
  file           = "$toolsPath\Win32OpenSSL_Light-1_1_0f.exe"
  file64         = "$toolsPath\Win64OpenSSL_Light-1_1_0f.exe"
  softwareName   = 'OpenSSL*Light*'
  silentArgs     = $silentArgs
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
$binPath = "$($dir)\bin" 
Install-ChocolateyPath -PathToInstall $binPath 

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
