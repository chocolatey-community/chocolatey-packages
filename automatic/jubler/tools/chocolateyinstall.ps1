$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/teras/Jubler/releases/download/v10.0.0/Jubler-10.0.0-x64.exe'
  checksum64     = 'cf8729148e2ce4a184cf5e0d953a43e20ca514cb7e3e2bde17a8a0a6bcbaa1b2'
  checksumType64 = 'sha256'
  softwareName   = 'Jubler*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
