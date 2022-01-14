$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/571ad766-28d1-4028-9063-0fa32401e78f/F02DEA65EA65633D1718E6C5E5EEE7D2DF640D1FFF332E4669DEA530B8C4F0E7/VC_redist.x86.exe'
  Checksum = 'f02dea65ea65633d1718e6c5e5eee7d2df640d1fff332e4669dea530b8c4f0e7'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/571ad766-28d1-4028-9063-0fa32401e78f/5D3D8C6779750F92F3726C70E92F0F8BF92D3AE2ABD43BA28C6306466DE8A144/VC_redist.x64.exe'
  Checksum64 = '5d3d8c6779750f92f3726c70e92f0f8bf92d3ae2abd43ba28c6306466de8a144'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.30.30708'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
