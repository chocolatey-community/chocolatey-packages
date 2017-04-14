$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    PackageName    = "putty.install"
    FileType       = "msi"
    SoftwareName   = "PuTTY"
    File           = "$toolsPath\putty-0.68-installer.msi"
    File64         = "$toolsPath\putty-64bit-0.68-installer.msi"
    SilentArgs     = "/quiet"
    ValidExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force "$toolsPath\*.msi","$toolsPath\*.ignore" -ea 0
