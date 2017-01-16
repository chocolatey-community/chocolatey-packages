$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$filePath = "$toolsPath\putty-0.67-installer.msi"

$packageArgs = @{
    PackageName    = "putty.install"
    FileType       = "msi"
    SoftwareName   = "PuTTY"
    File           = $filePath
    SilentArgs     = "/quiet"
    ValidExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force $filePath -ea 0
