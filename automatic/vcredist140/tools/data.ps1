$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/77091a7f-1547-40bd-96a6-575b3e7fb174/8AE59D82845159DB3A70763F5CB1571E45EBF6A1ADFECC47574BA17B019483A0/VC_redist.x86.exe'
  Checksum = '8ae59d82845159db3a70763f5cb1571e45ebf6a1adfecc47574ba17b019483a0'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/8b92f460-7e03-4c75-a139-e264a770758d/26C2C72FBA6438F5E29AF8EBC4826A1E424581B3C446F8C735361F1DB7BEFF72/VC_redist.x64.exe'
  Checksum64 = '26c2c72fba6438f5e29af8ebc4826a1e424581b3c446f8c735361f1db7beff72'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.34.31938'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
