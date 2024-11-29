$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://github.com/Tribler/tribler/releases/download/v8.0.5/Tribler_8.0.5_x86.exe'
  url64          = 'https://github.com/Tribler/tribler/releases/download/v8.0.5/Tribler_8.0.5_x64.exe'
  checksum       = '3183914c29ac692c10b9c1d82419506e15ef23b940c7577e33c32d80cf822a88'
  checksumType   = 'sha256'
  checksum64     = '690cc0652dc6a111fce2535b8aad59b90c719647dfd9227c026efebcd490c03c'
  checksumType64 = 'sha256'
  softwareName   = 'Tribler'
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}

Install-ChocolateyPackage @packageArgs
