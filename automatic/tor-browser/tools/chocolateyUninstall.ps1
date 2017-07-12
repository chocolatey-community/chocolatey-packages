$ErrorActionPreference = 'Stop'

$desktop = [System.Environment]::GetFolderPath('Desktop')

if (Test-Path "$desktop\Tor Browser.lnk") {
  Write-Host "Removing Desktop shortcut..."
  Remove-Item -Force -ea 0 "$desktop\Tor Browser.lnk"
}
