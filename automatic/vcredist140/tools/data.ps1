$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/7e8edcf6-f2c1-41b1-a712-3f9cd8f58db4/4C6C420CF4CBF2C9C9ED476E96580AE92A97B2822C21329A2E49E8439AC5AD30/VC_redist.x86.exe'
  Checksum = '4c6c420cf4cbf2c9c9ed476e96580ae92a97b2822c21329a2e49e8439ac5ad30'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/b929b7fe-5c89-4553-9abe-6324631dcc3a/296F96CD102250636BCD23AB6E6CF70935337B1BBB3507FE8521D8D9CFAA932F/VC_redist.x64.exe'
  Checksum64 = '296f96cd102250636bcd23ab6e6cf70935337b1bbb3507fe8521d8d9cfaa932f'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.29.30139'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
