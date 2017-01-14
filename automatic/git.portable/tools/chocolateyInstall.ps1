$ErrorActionPreference = 'Stop'

$toolsPath  = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath32 = "$toolsPath\PortableGit-2.11.0-32-bit.7z.exe"
$filePath64 = "$toolsPath\PortableGit-2.11.0-64-bit.7z.exe"

$filePath   = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
                     Write-Host "Installing 64 bit version"; $filePath64 }
              else { Write-Host "Installing 32 bit version"; $filePath32 }

$packageArgs = @{
    PackageName  = 'git.portable'
    FileFullPath = $filePath
    Destination  = "$(Get-ToolsLocation)\git"
}
Get-ChocolateyUnzip @packageArgs
Install-ChocolateyPath $packageArgs.Destination

$deprecatedInstallDir = Join-Path $env:systemdrive 'git'
if (Test-Path $deprecatedInstallDir) {
    Write-Host "Removing old installation at: $deprecatedInstallDir"
    Remove-Item $deprecatedInstallDir -recurse -force -ea 0
}

Remove-Item -force $filePath32, $filePath64 -ea 0
