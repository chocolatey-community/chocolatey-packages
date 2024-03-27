$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = $env:chocolateyPackageName
    FileFullPath   = "$toolsPath\curl-8.7.1_1-win32-mingw.zip"
    FileFullPath64 = "$toolsPath\curl-8.7.1_1-win64-mingw.zip"
    Destination    = $toolsPath
}

Get-ChildItem $toolsPath\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

Move-Item -Path "$toolsPath\cacert.pem" -Destination "$toolsPath\curl*\bin\curl-ca-bundle.crt" -Force
