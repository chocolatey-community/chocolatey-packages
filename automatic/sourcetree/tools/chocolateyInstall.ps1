$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.4.8.0.exe'

  softwareName = 'SourceTree'

  checksum = '7b48d591124b5fb28ffabc7f3a0d89e7dfa6d78e4ab30b158a64b976dbf82b50'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
