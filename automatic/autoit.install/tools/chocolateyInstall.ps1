$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\autoit-v3-setup.exe"

$packageArgs = @{
  PackageName    = 'autoit.install'
  FileType       = 'exe'
  SoftwareName   = 'AutoIt*'
  File           = $filePath
  SilentArgs     = '/S'
  ValidExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Remove-Item -Force $filePath
