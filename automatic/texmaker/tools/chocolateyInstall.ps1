$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if ((Get-ProcessorBits 32) -or $env:chocolateyForceX86 -eq $true) {
  throw "Version 5+ no longer supports 32bit, please install a version prior to 5.0 if you need 32bit."
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  file           = "$toolsPath\Texmaker_5.0.2_Win_x64.msi"
  softwareName   = 'Texmaker*'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.msi","$toolsPath\*.ignore"
