$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\gimp-2.8.22-setup.exe"
  softwareName   = 'GIMP'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).InnoSetup.log`""
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Force -ea 0 "$toolsPath\*.exe","$toolsPath\*.ignore"
