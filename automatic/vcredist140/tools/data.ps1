$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/8a78e61f-9368-484b-b0c1-5628ff392121/38C9437E6E9EF1DB2671B3F0C879FEBEC08521BD2C23231199F626B69AE1C65E/VC_redist.x86.exe'
  Checksum = '38c9437e6e9ef1db2671b3f0c879febec08521bd2c23231199f626b69ae1c65e'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/fed639fe-9f26-4a95-91f0-4c6e5cd55f2b/6AFAE68A783F11292149175844AED0E2CE3F247BC0250F6CB18C931295B3F399/VC_redist.x64.exe'
  Checksum64 = '6afae68a783f11292149175844aed0e2ce3f247bc0250f6cb18c931295b3f399'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.29.30157'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
