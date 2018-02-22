$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'ffmpeg'
    FileFullPath   = Get-Item $toolsPath\*_x32.zip
    FileFullPath64 = Get-Item $toolsPath\*_x64.zip    
    Destination    = $toolsPath
}

Get-ChildItem $toolsPath\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

Move-Item $toolsPath\ffmpeg-* $toolsPath\ffmpeg
