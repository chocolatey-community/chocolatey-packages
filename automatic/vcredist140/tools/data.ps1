$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/9613cb5b-2786-49cd-8d90-73abd90aa50a/29F649C08928B31E6BB11D449626DA14B5E99B5303FE2B68AFA63732EF29C946/VC_redist.x86.exe'
  Checksum = '29f649c08928b31e6bb11d449626da14b5e99b5303fe2b68afa63732ef29c946'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/9613cb5b-2786-49cd-8d90-73abd90aa50a/CEE28F29F904524B7F645BCEC3DFDFE38F8269B001144CD909F5D9232890D33B/VC_redist.x64.exe'
  Checksum64 = 'cee28f29f904524b7f645bcec3dfdfe38f8269b001144cd909f5d9232890d33b'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.29.30153'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
