$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = 'nodejs.install'
  FileType       = 'msi'
  SoftwareName   = 'Node.js'
  File           = ''
  File64         = "$toolsPath\node-v25.7.0-x64.msi"
  SilentArgs     = '/quiet ADDLOCAL=ALL'
  ValidExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force "$toolsPath\*.exe","$toolsPath\*.msi" -ea 0
