$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\helpers.ps1"

$initialProcessCount = Get-ExplorerProcessCount
Write-Warning "This installer is known to close the explorer process. This means `nyou may lose current work. `nIf it doesn't automatically restart explorer, type 'explorer' on the `ncommand shell to restart it."

$filePath32 = "$toolsDir\7zip_x32.exe"
$filePath64 = "$toolsDir\7zip_x64.exe"

$filePath = if ((Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne $true) {
  Write-Host "Installing 64 bit version" ; $filePath64
} else { Write-Host "Installing 32 bit version" ; $filePath32 }

$packageArgs = @{
  packageName    = '7zip.install'
  fileType       = 'exe'
  softwareName   = '7-zip*'
  file           = "$filePath"
  silentArgs     = '/S'
  validExitCodes = @(0)
}

# To prevent shimming of installers
"" | Out-File "$filePath32.ignore"
"" | Out-File "$filePath64.ignore"

Install-ChocolateyInstallPackage @packageArgs

$finalProcessCount = Get-ExplorerProcessCount
if($initialProcessCount -lt $finalProcessCount)
{
  Start-Process explorer.exe
}

Remove-Item "$filePath32*","$filePath64*" -Force -ea 0
