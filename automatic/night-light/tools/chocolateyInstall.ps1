$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  fileFullPath = "$toolsDir\night-light.exe"
  url          = 'https://github.com/Enyium/sem-reg-rs/releases/download/v0.1.0/night-light.exe'
  checksum     = '294D7146ECC981EC3DD49DE64B643F5F91F293524DC9277AF80E64A8C3F9BE3E'
  checksumType = 'sha256'
}
Get-ChocolateyWebFile @packageArgs