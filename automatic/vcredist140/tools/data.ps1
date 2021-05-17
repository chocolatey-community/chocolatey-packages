$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/85d47aa9-69ae-4162-8300-e6b7e4bf3cf3/14563755AC24A874241935EF2C22C5FCE973ACB001F99E524145113B2DC638C1/VC_redist.x86.exe'
  Checksum = '14563755ac24a874241935ef2c22c5fce973acb001f99e524145113b2dc638c1'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/85d47aa9-69ae-4162-8300-e6b7e4bf3cf3/52B196BBE9016488C735E7B41805B651261FFA5D7AA86EB6A1D0095BE83687B2/VC_redist.x64.exe'
  Checksum64 = '52b196bbe9016488c735e7b41805b651261ffa5d7aa86eb6a1d0095be83687b2'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.28.29914'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
