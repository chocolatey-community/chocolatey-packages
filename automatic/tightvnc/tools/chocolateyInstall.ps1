$url32       = 'http://www.tightvnc.com/download/2.8.5/tightvnc-2.8.5-gpl-setup-32bit.msi'
$url64       = 'http://www.tightvnc.com/download/2.8.5/tightvnc-2.8.5-gpl-setup-64bit.msi'
$checksum32  = '4504cc34153e52bb1f8bcebd864e951a38fd290aec71a54f6031b2fcf1cd1fcf'
$checksum64  = '2029b35d044590fe27f857032b26210d8139246fbd430b352a3644c3e5d99011'

$packageArgs = @{
  packageName   = 'tightvnc'
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'msi'
  url           = $url32
  url64         = $url64
  silentArgs    = '/quiet /norestart'
  validExitCodes= @(0)
  softwareName  = 'steam*'
  checksum      = $checksum32
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'
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
