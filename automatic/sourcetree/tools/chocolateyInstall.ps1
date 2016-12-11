$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = 'sourcetree'
  fileType = 'EXE'
  url = ''
  url64bit = ''

  softwareName = 'SourceTree'

  checksum = ''
  checksumType = 'sha256'
  checksum64 = ''
  checksumType64= 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
