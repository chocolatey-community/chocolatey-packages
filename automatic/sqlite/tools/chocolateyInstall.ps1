$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$embedded_path = if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne 'true') {
         Write-Host "Installing 64 bit version"; Get-Item "$toolsDir\*dll*win64*.zip"
} else { Write-Host "Installing 32 bit version"; Get-Item "$toolsDir\*dll*win32*.zip" }

$packageArgs = @{
    PackageName  = 'sqlite'
    FileFullPath = $embedded_path
    Destination  = $toolsDir
}
Get-ChildItem $toolsDir\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs

$pp = Get-PackageParameters
if (!$pp.NoTools) {
    Write-Host "Installing tools"
    $packageArgs.FileFullPath = Get-Item "$toolsDir\*tools*win32*.zip"
    Get-ChocolateyUnzip @packageArgs
}

Remove-Item $toolsDir\*.zip -ea 0