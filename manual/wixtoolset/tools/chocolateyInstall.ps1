$packageParameters = @{
  PackageName = 'wixtoolset'
  FileType = 'exe'
  SilentArgs = '/q'
  Url = 'http://wixtoolset.org/downloads/v3.11.0.1528/wix311.exe'
  ValidExitCodes = @(0)
  Checksum = '8665634d6e051eea7259438d1be2e1f052dccffc4b254ff826f251fe54051a18'
  ChecksumType = 'Sha256'
}

Install-ChocolateyPackage @packageParameters
