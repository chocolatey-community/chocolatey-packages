$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$fileName = if ((Get-ProcessorBits 64) -and ($env:chocolateyForceX86 -ne 'true')) {
  Write-Host "Installing 64 bit version" ; 'qbittorrent_4.0.3_x64_setup.exe' # 64-bit
} else {
  Write-Host "Installing 32 bit version" ; 'qbittorrent_4.0.3_setup.exe' # 32-bit
}

$packageArgs = @{
  packageName    = 'qbittorrent'
  fileType       = 'exe'
  softwareName   = 'qBittorrent*'
  file           = "$toolsDir\$fileName"
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Remove-Item -Force "$toolsDir\*.exe","$toolsDir\*.exe.ignore" -ea 0

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$($packageArgs.packageName) installed to '$installLocation'"
  Register-Application "$installLocation\qbittorrent.exe"
  Register-Application "$installLocation\qbittorrent.exe" "qbit"
} else {
  Write-Warning "Can't find $($packageArgs.packageName) install location"
}
