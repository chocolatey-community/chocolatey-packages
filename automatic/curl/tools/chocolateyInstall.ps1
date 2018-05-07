$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'less'
    FileFullPath   = Get-Item $toolsPath\*-win32-*.zip
    FileFullPath64 = Get-Item $toolsPath\*-win64-*.zip    
    Destination    = $toolsPath
}

Get-ChildItem $toolsPath\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

Move-Item -Path "$toolsPath\cacert.pem" -Destination "$toolsPath\curl*\bin\curl-ca-bundle.crt" -Force
