$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; gi "$toolsDir\*_x64.exe"
} else { Write-Host "Installing 32 bit version"; gi "$toolsDir\*_x32.exe" }

$packageArgs = @{
  packageName    = 'qtox'
  fileType       = 'exe'
  softwareName   = 'qTox'
  file           = $embedded_path
  silentArgs     = '/S'
  validExitCodes = @(0)
}

Install-ChocolateyInstallPackage @packageArgs
rm -force -ea 0 $toolsDir\*.exe, $toolsDir\*.ignore
