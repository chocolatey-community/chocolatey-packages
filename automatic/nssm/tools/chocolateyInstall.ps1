$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; $is64 = $true
} else { Write-Host "Installing 32 bit version"} 

$packageArgs = @{
    PackageName  = 'nssm'
    FileFullPath = Get-Item $toolsDir\*.zip
    Destination  = $toolsDir
}
Get-ChildItem $toolsDir\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs

$source = if ($is64) { 'win64' } else { 'win32' }
Copy-Item $toolsDir\nssm-*\$source\nssm.exe $toolsDir
Remove-Item -Force $toolsDir\nssm*.zip -ea 0
Remove-Item -Recurse $toolsDir\nssm-*
