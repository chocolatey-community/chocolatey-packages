$installData32 = @{
  Url = 'https://download.microsoft.com/download/1/d/8/1d8137db-b5bb-4925-8c5d-927424a2e4de/vc_redist.x86.exe'
  Checksum = '20F456AAB2938D638E9E08EBCAF576C5A0BC7C1AD447645F1F07A26B147DBBFA'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.microsoft.com/download/5/7/b/57b2947c-7221-4f33-b35e-2fc78cb10df4/vc_redist.x64.exe'
  Checksum64 = '341D4BAA491DAA5BEBD0E061577E3F840C8157417C636FD2285D9BDF71FC4660'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2017 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.10.25008'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
