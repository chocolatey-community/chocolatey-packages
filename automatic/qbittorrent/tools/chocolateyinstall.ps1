$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'qbittorrent'
  fileType       = 'exe'
  softwareName   = 'qBittorrent*'
  file           = "$toolsDir\qbittorrent_4.1.3_setup.exe"
  file64         = "$toolsDir\qbittorrent_4.1.3_x64_setup.exe"
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer as there is no more need for it
Get-ChildItem $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if ($installLocation) {
  Write-Host "$($packageArgs.packageName) installed to '$installLocation'"
  Register-Application "$installLocation\qbittorrent.exe"
  Register-Application "$installLocation\qbittorrent.exe" "qbit"
} else {
  Write-Warning "Can't find $($packageArgs.packageName) install location"
}
