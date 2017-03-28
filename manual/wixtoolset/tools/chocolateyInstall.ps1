$packageParameters = @{
  PackageName = 'wixtoolset'
  SilentArgs = '/q'
  Url = 'http://wixtoolset.org/downloads/v3.11.0.1507/wix311.exe'
  Url64bit = ''
  ValidExitCodes = @('0')
  Checksum = '407e00a2c8787c347e6963091d066b0e2530866a161a59a88c56817cf88e9367'
  ChecksumType = 'Sha256'
  Checksum64 = ''
  ChecksumType64 = ''
}

Install-ChocolateyPackage @packageParameters
