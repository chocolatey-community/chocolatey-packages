$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tightvnc'
  fileType       = 'msi'
  url            = 'https://www.tightvnc.com/download/2.8.11/tightvnc-2.8.11-gpl-setup-32bit.msi'
  url64bit       = 'https://www.tightvnc.com/download/2.8.11/tightvnc-2.8.11-gpl-setup-64bit.msi'
  checksum       = 'eefda3f6dbf599a3679aa4cced15dd2e766e37ed1536ad2868d7748e3f44e68f'
  checksum64     = 'ec42c674b06b37b5d6be32875356df29bb11e1d4e63bbf6049a91f01f0053e9a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/quiet /norestart'
  validExitCodes = @(0)
  softwareName   = 'tightvnc*'
}
Install-ChocolateyPackage @packageArgs

# This reads the service start mode of 'TightVNC Server' and adapts it to the current value,
# otherwise it would always be set to 'Auto' on new installations, even if it was 'Manual'
# or 'disabled' before
$serviceStartMode = (Get-wmiobject win32_service -Filter "Name = 'tvnserver'").StartMode

if ($serviceStartMode -ne $null) {
  if ($serviceStartMode -ne 'Auto') {
    Start-ChocolateyProcessAsAdmin "Set-Service -Name tvnserver -StartupType $serviceStartMode"
  }
}
