$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$filePath32 = "$toolsPath\node-v9.3.0-x86.msi"
$filePath64 = "$toolsPath\node-v9.3.0-x64.msi"
$installFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
                      Write-Host "Installing 64 bit version"; $filePath64 }
               else { Write-Host "Installing 32 bit version"; $filePath32 }

$packageArgs = @{
  PackageName    = 'nodejs.install'
  FileType       = 'msi'
  SoftwareName   = 'Node.js'
  File           = $installFile
  SilentArgs     = "/quiet"
  ValidExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force $filePath32, $filePath64 -ea 0
