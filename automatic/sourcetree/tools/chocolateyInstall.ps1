$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = 'sourcetree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/SourceTreeSetup_1.9.10.0.exe'

  softwareName = 'SourceTree'

  checksum = '0d4bb9f9f6835f0dcdd46cd0dae38f1958bde09ebf41b7555e7115ffcadff837'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
