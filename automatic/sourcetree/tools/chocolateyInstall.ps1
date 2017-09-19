$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.3.1.0.exe'

  softwareName = 'SourceTree'

  checksum = 'b33dc517013bdc5c06ee2f0c48894abf6fa1328fddbe78f9d38b66504d8607f6'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
