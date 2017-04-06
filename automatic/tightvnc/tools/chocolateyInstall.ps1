$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'tightvnc'
  fileType       = 'msi'
  url            = 'http://www.tightvnc.com/download/2.8.8/tightvnc-2.8.8-gpl-setup-32bit.msi'
  url64bit       = 'http://www.tightvnc.com/download/2.8.8/tightvnc-2.8.8-gpl-setup-64bit.msi'
  checksum       = '1e2088ec30823ada6ca27225424209a24d796301c4e57a32db2dcb6161aa1ddd'
  checksum64     = '47bc1e8cce620e996da4b67aa886ae9ea854ec13e94d05928b6bf4af8ce17ef1'
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
