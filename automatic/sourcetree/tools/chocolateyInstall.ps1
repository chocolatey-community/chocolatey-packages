$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.5.4.exe'

  softwareName = 'SourceTree'

  checksum = '3ad3b5ddb7663b3a6c67c341acd4ceabb63ada9234493bdc4df90529acf8b072'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
