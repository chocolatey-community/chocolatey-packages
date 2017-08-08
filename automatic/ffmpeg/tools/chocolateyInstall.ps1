$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'ffmpeg'
    FileFullPath   = gi $toolsPath\*_x32.zip
    FileFullPath64 = gi $toolsPath\*_x64.zip    
    Destination    = $toolsPath
}

ls $toolsPath\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

mv $toolsPath\ffmpeg-* $toolsPath\ffmpeg
