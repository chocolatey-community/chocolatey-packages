$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = 'bluefish'
  fileType      = 'exe'
  softwareName  = 'Bluefish*'

  checksum      = '4f2ab210c68f2e3c382708aae68ad0d881463bb7c2bf42ca2fd250a34e099ffa'
  checksumType  = 'sha256'
  url           = 'https://www.bennewitz.com/bluefish/stable/binaries/win32/Bluefish-2.2.9-setup.exe'

  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
