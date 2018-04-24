$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.5.5.exe'

  softwareName = 'SourceTree'

  checksum = 'b4309a4581a515d3498a75e9c810ae2b16adf239107486f481d9a0236240ee5f'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
