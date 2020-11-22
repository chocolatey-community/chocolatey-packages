$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'ffmpeg'
    FileFullPath64 = Get-Item $toolsPath\*.7z
    Destination    = $toolsPath
}

Get-ChildItem $toolsPath\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.7z -ea 0

Move-Item $toolsPath\ffmpeg-* $toolsPath\ffmpeg
