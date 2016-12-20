$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tightvnc'
  fileType       = 'msi'
  url            = 'http://www.tightvnc.com/download/2.8.5/tightvnc-2.8.5-gpl-setup-32bit.msi'
  url64bit       = 'http://www.tightvnc.com/download/2.8.5/tightvnc-2.8.5-gpl-setup-64bit.msi'
  checksum       = '4504cc34153e52bb1f8bcebd864e951a38fd290aec71a54f6031b2fcf1cd1fcf'
  checksum64     = '2029b35d044590fe27f857032b26210d8139246fbd430b352a3644c3e5d99011'
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
