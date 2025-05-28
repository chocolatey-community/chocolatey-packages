$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/2c6b06c4-dc6a-4496-b769-b0d311cf515d/54CCBBC0663064F0B57442DC986511B90F3CFAAB23524087B0711E6FA214CB26/VC_redist.x86.exe'
  Checksum = '54ccbbc0663064f0b57442dc986511b90f3cfaab23524087b0711e6fa214cb26'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/2c6b06c4-dc6a-4496-b769-b0d311cf515d/463F736D5925566EDC0E8F7D8E70C0A1FC95ADF44AFA5D5390B979F5A35934CC/VC_redist.x64.exe'
  Checksum64 = '463f736d5925566edc0e8f7d8e70c0a1fc95adf44afa5d5390b979f5a35934cc'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.44.35112'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
