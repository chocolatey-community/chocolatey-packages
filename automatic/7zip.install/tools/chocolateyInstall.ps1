$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = if ((Get-OSArchitectureWidth 64) -and $env:chocolateyForceX86 -ne $true) {
       Write-Host "Installing 64 bit version" ; Get-Item $toolsDir\*_x64.exe }
else { Write-Host "Installing 32 bit version" ; Get-Item $toolsDir\*_x32.exe }

$packageArgs = @{
  packageName    = '7zip.install'
  fileType       = 'exe'
  softwareName   = '7-zip*'
  file           = $filePath
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -ea 0 -force

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find 7zip install location"; return }
Write-Host "7zip installed to '$installLocation'"

Install-BinFile '7z' $installLocation\7z.exe
