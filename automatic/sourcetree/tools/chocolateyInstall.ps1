$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.3.5.0.exe'

  softwareName = 'SourceTree'

  checksum = '0e02ea2ab6dc4a4e5d4b12be50705bb840f01d978a46757b24ca5a818bb75bd8'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
