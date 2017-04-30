$ErrorActionPreference = 'Stop'

$toolsPath  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    PackageName  = "putty.portable"
    File         = "$toolsPath\putty_x32.zip"
    File64       = "$toolsPath\putty_x64.zip"
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs

Remove-Item -force "$toolsPath\*.zip" -ea 0
