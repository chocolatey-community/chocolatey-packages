﻿$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\git-lfs-windows-v3.0.2.exe"

$packageArgs = @{
  PackageName    = 'git-lfs'
  FileType       = 'exe'
  SoftwareName   = 'Git LFS*'
  File           = $filePath
  SilentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  ValidExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Remove-Item -Force $filePath
