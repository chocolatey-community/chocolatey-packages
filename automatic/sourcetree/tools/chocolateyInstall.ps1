$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = 'SourceTree'
  fileType = 'EXE'
  url = 'https://downloads.atlassian.com/software/sourcetree/windows/ga/SourceTreeSetup-2.1.10.0.exe'

  softwareName = 'SourceTree'

  checksum = 'aeee578f62495efb4edee4854036b3d9d3f7747ffcbdc0975a6e669acd8efc8a'
  checksumType = 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
