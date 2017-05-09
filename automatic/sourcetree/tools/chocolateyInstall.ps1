$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = 'sourcetree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.0.20.1.exe'

  softwareName = 'SourceTree'

  checksum = '4eb706d8ffc7c6c30a1e5c677147ff09da4ba70aa8be01b2a7edce46af902eba'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
