$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$tcmdWork = Get-PackageCacheLocation
Extract-TCFiles
Set-TCParameters

$packageArgs = @{
    PackageName    = 'totalcommander'
    FileType       = 'exe'
    File           = "$tcmdWork\INSTALL.exe"
    SilentArgs     = ''
    ValidExitCodes = @(0)
    SoftwareName   = 'Total Commander*'
}
Install-ChocolateyInstallPackage @packageArgs
Write-Verbose "Removing package files"
rm $toolsPath\*.exe, $toolsPath\*.zip -ea 0
