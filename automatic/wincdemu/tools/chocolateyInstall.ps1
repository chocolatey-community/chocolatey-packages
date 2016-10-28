$ErrorActionPreference = 'Stop'

$tools = Split-Path -parent $MyInvocation.MyCommand.Definition
Write-Host 'Adding program certificate: sysprogs.cer'
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\sysprogs.cer'" | Out-Null

$packageArgs = @{
  packageName            = 'wincdemu'
  fileType               = 'EXE'
  url                    = 'http://sysprogs.com/files/WinCDEmu/WinCDEmu-4.1.exe'
  url64bit               = 'http://sysprogs.com/files/WinCDEmu/WinCDEmu-4.1.exe'
  checksum               = '7716e2e5165402bc3337147ee555bc1b4641fe5fdfdc72329e08753697fe1b90'
  checksum64             = '7716e2e5165402bc3337147ee555bc1b4641fe5fdfdc72329e08753697fe1b90'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/UNATTENDED'
  validExitCodes         = @(0)
  softwareName           = 'wincdemu.*'
}
Install-ChocolateyPackage @packageArgs
