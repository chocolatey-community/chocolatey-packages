$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/73b58d04-0049-47d1-9f54-1784792c71cd/80C7969F4E05002A0CD820B746E0ACB7406D4B85E52EF096707315B390927824/VC_redist.x86.exe'
  Checksum = '80c7969f4e05002a0cd820b746e0acb7406d4b85e52ef096707315b390927824'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/d3cbdace-2bb8-4dc5-a326-2c1c0f1ad5ae/9B9DD72C27AB1DB081DE56BB7B73BEE9A00F60D14ED8E6FDE45DAB3E619B5F04/VC_redist.x64.exe'
  Checksum64 = '9b9dd72c27ab1db081de56bb7b73bee9a00f60d14ed8e6fde45dab3e619b5f04'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.29.30135'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
