$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'sqlite'
    FileFullPath   = (Get-Item "$toolsDir\*dll*win-x86*.zip")
    FileFullPath64 = (Get-Item "$toolsDir\*dll*win-x64*.zip")
    Destination    = $toolsDir
}
Get-ChildItem $toolsDir\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs

$pp = Get-PackageParameters
if (!$pp.NoTools) {
    if ((Get-OSArchitectureWidth -Compare 32) -or ($env:chocolateyForceX86 -eq 'true')) {
        Write-Error -Message "32-bit version of sqlite tools not available after version 3.43.2" -Category ResourceUnavailable
    }
    Write-Host "Installing tools"
    $packageArgs.FileFullPath64 = Get-Item "$toolsDir\*tools*win-x64*.zip"
    Get-ChocolateyUnzip @packageArgs
}

Remove-Item $toolsDir\*.zip -ea 0
