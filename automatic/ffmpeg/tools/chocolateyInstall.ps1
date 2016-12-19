$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; gi "$toolsPath\*_x64.zip"
} else { Write-Host "Installing 32 bit version"; gi "$toolsPath\*_x32.zip" }

$packageArgs = @{
  PackageName    = 'ffmpeg'
  FileFullPath   = $embedded_path
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
