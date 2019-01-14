$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v7.1.4/Tribler_7.1.4_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v7.1.4/Tribler_7.1.4_x64.exe'
  checksum       = '66a9f691cb07e464954681a5182dac5ceba669fd3b4f1aef0115a30035e98efb'
  checksumType   = 'sha256'
  checksum64     = '14bb47736d705433c621c3fea88ca2eb7f249c519bb18aa894582860727bb1ea'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
