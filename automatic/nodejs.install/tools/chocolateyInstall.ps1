$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = 'nodejs.install'
  FileType       = 'msi'
  SoftwareName   = 'Node.js'
  File           = "$toolsPath\"
  File64         = "$toolsPath\"
  SilentArgs     = '/quiet ADDLOCAL=ALL'
  ValidExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force "$toolsPath\*.exe","$toolsPath\*.msi" -ea 0
