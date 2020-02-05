$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.4.1/Tribler_7.4.1_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.4.1/Tribler_7.4.1_x64.exe'
  checksum       = '53c63d3146d212b44f0f783a25c6c8c146cb302fb742a6b1537219b5e4ab466b'
  checksumType   = 'sha256'
  checksum64     = '05529d29eeab7906934a19ebcd8935fa72c09b69dfd32b4a3a49b0c02bd97ec2'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
