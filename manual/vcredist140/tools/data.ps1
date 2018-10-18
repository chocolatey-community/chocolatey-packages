$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/749aa419-f9e4-4578-a417-a43786af205e/d59197078cc425377be301faba7dd87a/vc_redist.x86.exe'
  Checksum = 'B194C31198E681A94AB1744D7704716CFC6E05CDEF157AB60367284192F6C088'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/20ef12bb-5283-41d7-90f7-eb3bb7355de7/8b58fd89f948b2430811db3da92299a6/vc_redist.x64.exe'
  Checksum64 = '42A559F2BE251B5F3C685597B99E4DEE763B16A01F70BD7B1E92F6EB91CBB80C'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2017 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.15.26706'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
