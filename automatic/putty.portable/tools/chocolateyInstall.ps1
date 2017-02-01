$ErrorActionPreference = 'Stop'

$toolsPath  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsPath\putty.zip"

$packageArgs = @{
    PackageName  = "putty.portable"
    FileFullPath = $filePath
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs

Remove-Item -force $filePath -ea 0
