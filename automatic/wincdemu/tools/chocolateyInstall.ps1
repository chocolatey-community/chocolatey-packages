$ErrorActionPreference = 'Stop'

$cert = ls cert: -Recurse | ? { $_.Thumbprint -eq '8880a2309be334678e3d912671f22049c5a49a78' }
if (!$cert) {
    Write-Host 'Adding program certificate: sysprogs.cer'
    $toolsPath = Split-Path $MyInvocation.MyCommand.Definition
    Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\sysprogs.cer'"
}

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
