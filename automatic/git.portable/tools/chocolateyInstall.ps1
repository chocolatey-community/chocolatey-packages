$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath32 = "$toolsPath\PortableGit-2.11.0-32-bit.7z.exe"
$filePath64 = "$toolsPath\PortableGit-2.11.0-64-bit.7z.exe"

$filePath = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true') {
  Write-Host "Installing 64 bit version"
  $filePath64
} else { 
  Write-Host "Installing 32 bit version"
  $filePath32
}

$installLocation = Join-Path $(Get-ToolsLocation) 'git'

Get-ChocolateyUnzip -FileFullPath $filePath -Destination $installLocation

# Add to path
$gitBinPath = Join-Path $installLocation 'bin'
Install-ChocolateyPath $gitBinPath 'Machine'
$env:Path = "$($env:Path);$gitBinPath"

# Remove old installations
$deprecatedInstallDir = Join-Path $env:systemdrive 'git'
if (Test-Path $deprecatedInstallDir) { Remove-Item $deprecatedInstallDir -recurse -force -ErrorAction SilentlyContinue }

# Lets remove the ZIP files as there is no more need for it
Remove-Item -Force $filePath32 -ea 0
Remove-Item -Force $filePath64 -ea 0