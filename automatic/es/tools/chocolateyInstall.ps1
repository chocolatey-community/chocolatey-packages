$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = 'es'
    FileFullPath   = "$toolsDir\ES-1.1.0.27.x86.zip"
    FileFullPath64 = "$toolsDir\ES-1.1.0.27.x64.zip"
    Destination    = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

Remove-Item -Path $toolsDir\*.zip -Force -EA 0
