
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

if (Test-Path $toolsPath\chocoUninstall.ps1) {
    . $toolsPath\chocoUninstall.ps1
}
