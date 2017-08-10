$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$filePath32 = "$toolsPath\TortoiseSVN-1.9.7.27907-win32-svn-1.9.7.msi"
$filePath64 = "$toolsPath\TortoiseSVN-1.9.7.27907-x64-svn-1.9.7.msi"

$installFile = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Installing 64 bit version"
  $filePath64
} else { 
  Write-Host "Installing 32 bit version"
  $filePath32
}

$packageArgs = @{
    PackageName = 'tortoisesvn'
    FileType = 'msi'
    SoftwareName = 'TortoiseSVN*'
    File = $installFile
    SilentArgs = '/quiet /qn /norestart ADDLOCAL=ALL'
    ValidExitCodes = @(0,3010)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it.
Remove-Item -Force $filePath32 -ea 0
Remove-Item -Force $filePath64 -ea 0
