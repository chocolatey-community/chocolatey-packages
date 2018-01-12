$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.4.7.0.exe'

  softwareName = 'SourceTree'

  checksum = '359eb011a214233aff360f0e2f17d54441ff21b2422a9c71ff831b816f5438fe'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
