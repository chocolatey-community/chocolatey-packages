$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$silentArgs = '/silent','/sp-','/suppressmsgboxes'
if ($pp.InstallDir) { $silentArgs += @("/DIR=`"$($pp.InstallDir)`"") }
else {
  $silentArgs += @("/DIR=`"$env:ProgramFiles\OpenSSL`"")
}

$packageArgs = @{
  packageName    = 'OpenSSL.Light'
  fileType       = 'exe'
  file           = "$toolsPath\Win32OpenSSL_Light-1_1_0e.exe"
  file64         = "$toolsPath\Win64OpenSSL_Light-1_1_0e.exe"
  softwareName   = 'OpenSSL*Light*'
  silentArgs     = $silentArgs
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
