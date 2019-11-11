$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'juju'
  fileType      = 'exe'
  softwareName  = 'Juju'
  file          = "$toolsDir\juju-setup-2.7-rc3.exe"
  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"${env:TEMP}\${env:chocolateyPackageName}.${env:chocolateyPackageVersion}.Install.log`""
  validExitCodes= @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force $packageArgs.file
