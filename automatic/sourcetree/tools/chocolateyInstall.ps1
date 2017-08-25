$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.1.11.0.exe'

  softwareName = 'SourceTree'

  checksum = 'be92a608935949be668fe210efb8c891f7d647beeff1b9cfd57c55dc9a373219'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
