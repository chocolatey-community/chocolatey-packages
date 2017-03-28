$packageParameters = @{
  PackageName = 'wixtoolset'
  FileType = 'exe'
  SilentArgs = '/q'
  Url = 'http://wixtoolset.org/downloads/v3.10.3.3007/wix310.exe'
  ValidExitCodes = @(0)
  Checksum = '3C125E3551C035F69ED24ACD8FB4EF7B74C1311ECACF1F8FC1EB7E0DD47D9C75'
  ChecksumType = 'Sha256'
}

Install-ChocolateyPackage @packageParameters
