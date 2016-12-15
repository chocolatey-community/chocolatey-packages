$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName = 'sourcetree'
  fileType = 'EXE'
  url = 'http://downloads.atlassian.com/software/sourcetree/windows/SourceTreeSetup_1.9.9.20.exe'
  url64bit = 'http://downloads.atlassian.com/software/sourcetree/windows/SourceTreeSetup_1.9.9.20.exe'

  softwareName = 'SourceTree'

  checksum = '62f795e548bac9ab41e8d545945636fd77f5e621af38997cf4554cd4420b6a4f'
  checksumType = 'sha256'
  checksum64 = '62f795e548bac9ab41e8d545945636fd77f5e621af38997cf4554cd4420b6a4f'
  checksumType64= 'sha256'

  silentArgs = "/passive"
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
