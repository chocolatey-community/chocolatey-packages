$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/0c1cfec3-e028-4996-8bb7-0c751ba41e32/1abed1573f36075bfdfc538a2af00d37/vc_redist.x86.exe'
  Checksum = '8a8b3995620aeda29d2d99359172c7a3be17720b627a2b09cb293e8c1a76b41b'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/cc0046d4-e7b4-45a1-bd46-b1c079191224/9c4042a4c2e6d1f661f4c58cf4d129e9/vc_redist.x64.exe'
  Checksum64 = '6ed7281196f390184dbca70cb5604be5759095693c232a1232699b014828c794'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.22.27821'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
