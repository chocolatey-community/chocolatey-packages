$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/366c0fb9-fe05-4b58-949a-5bc36e50e370/E830C313AA99656748F9D2ED582C28101EAAF75F5377E3FB104C761BF3F808B2/VC_redist.x86.exe'
  Checksum = 'e830c313aa99656748f9d2ed582c28101eaaf75f5377e3fb104c761bf3f808b2'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/366c0fb9-fe05-4b58-949a-5bc36e50e370/015EDD4E5D36E053B23A01ADB77A2B12444D3FB6ECCEFE23E3A8CD6388616A16/VC_redist.x64.exe'
  Checksum64 = '015edd4e5d36e053b23a01adb77a2b12444d3fb6eccefe23e3a8cd6388616a16'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.28.29913'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
