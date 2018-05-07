$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = 'less'
    FileFullPath   = gi $toolsPath\*-win32-*.zip
    FileFullPath64 = gi $toolsPath\*-win64-*.zip    
    Destination    = $toolsPath
}

ls $toolsPath\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

Move-Item -Path "$toolsPath\cacert.pem" -Destination "$toolsPath\curl*\bin\curl-ca-bundle.crt" -Force
