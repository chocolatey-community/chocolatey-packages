$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/teras/Jubler/releases/download/v10.0.0/Jubler-10.0.0-x64.exe'
  checksum64     = 'CF8729148E2CE4A184CF5E0D953A43E20CA514CB7E3E2BDE17A8A0A6BCBAA1B2'
  checksumType64 = 'sha256'
  softwareName   = 'Jubler*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
