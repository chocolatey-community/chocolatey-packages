$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$filePath32 = "$toolsPath\qtox_x86.exe"
$filePath64 = "$toolsPath\qtox_x64.exe"

$filePath = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
  Write-Host "Installing 64-bit version" ; $filePath64
} else { Write-Host "Installing 32-bit version" ; $filePath32 }

$packageArgs = @{
  packageName    = 'qtox'
  fileType       = 'exe'
  softwareName   = 'qTox'
  file           = $filePath
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 $filePath32,$filePath64,"$filePath32.ignore","$filePath64.ignore"
