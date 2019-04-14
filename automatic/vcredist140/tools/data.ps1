$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/092cda8f-872f-47fd-b549-54bbb8a81877/ddc5ec3f90091ca690a67d0d697f1242/vc_redist.x86.exe'
  Checksum = '261f8122ce3e3da66fe4300e2a88325469251da85b62fbddb03ec49f97b62c14'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/21614507-28c5-47e3-973f-85e7f66545a4/f3a2caa13afd59dd0e57ea374dbe8855/vc_redist.x64.exe'
  Checksum64 = '14b07d8f4108a8b8b306af3f6fe6eb78814dfadebd500416fb24856ad668518e'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.20.27508'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
