$ErrorActionPreference = 'Stop'

$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$filePath32    = "$toolsDir\7zip_x32.exe"
$filePath64    = "$toolsDir\7zip_x64.exe"
$filePathExtra = "$toolsDir\7zip_extra.7z"

$packageArgs = @{
  packageName = '7zip.portable'
  destination = "$toolsDir"
  file = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
    Write-Host "Installing 64 bit version" ; $filePath64
  } else {
    Write-Host "Installing 32 bit version" ; $filePath32
  }
}
Get-ChocolateyUnzip @packageArgs

$packageArgs.packageName = '7zip.portable Extras'
$packageArgs.destination = "$toolsDir\7z-extra"
$packageArgs.file        = $filePathExtra
Get-ChocolateyUnzip @packageArgs

Remove-Item -Path "$toolsDir\Uninstall.exe",$filePath32,$filePath64,$filePathExtra -Force -ea 0

if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
  #generate ignore for 7za.exe and let x64 version pick up and shim
  New-Item "$($packageArgs.destination)\7za.exe.ignore" -Type file -Force | Out-Null
} else {
  # generate ignore for x64\7za.exe
  New-Item "$($packageArgs.destination)\x64\7za.exe.ignore" -Type file -Force | Out-Null
}
