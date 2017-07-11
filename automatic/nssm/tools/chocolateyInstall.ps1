$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; $rm = 'win32'
} else { Write-Host "Installing 32 bit version"; $rm = 'win64'} 

$packageArgs = @{
    PackageName  = 'nssm'
    FileFullPath = gi $toolsDir\*.zip
    Destination  = $toolsDir
}
ls $toolsDir\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm -Recurse -Force $toolsDir\*.zip, $toolsDir\nssm-*\$rm -ea 0
