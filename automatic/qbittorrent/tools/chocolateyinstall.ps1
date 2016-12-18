$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\qbittorrent_3.3.10_setup.exe"

$packageArgs = @{
  packageName    = 'qbittorrent'
  fileType       = 'exe'
  softwareName   = 'qBittorrent*'
  file           = $filePath
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Remove-Item -Force $filePath

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$($packageArgs.packageName) installed to '$installLocation'"
  Register-Application "$installLocation\qbittorrent.exe"
  Register-Application "$installLocation\qbittorrent.exe" "qbit"
} else {
  Write-Warning "Can't find $($packageArgs.packageName) install location"
}
