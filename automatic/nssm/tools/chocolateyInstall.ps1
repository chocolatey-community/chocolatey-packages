$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; $is64 = $true
} else { Write-Host "Installing 32 bit version"} 

$packageArgs = @{
    PackageName  = 'nssm'
    FileFullPath = gi $toolsDir\*.zip
    Destination  = $toolsDir
}
ls $toolsDir\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs

$source = if ($is64) { 'win64' } else { 'win32' }
cp $toolsDir\nssm-*\$source\nssm.exe $toolsDir
rm -Force $toolsDir\nssm*.zip -ea 0
rm -Recurse $toolsDir\nssm-*
