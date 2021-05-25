$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/76a91598-ca94-410b-b874-c7fa26e400da/91C21C93A88DD82E8AE429534DACBC7A4885198361EAE18D82920C714E328CF9/VC_redist.x86.exe'
  Checksum = '91c21c93a88dd82e8ae429534dacbc7a4885198361eae18d82920c714e328cf9'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/f1998402-3cc0-466f-bd67-d9fb6cd2379b/A1592D3DA2B27230C087A3B069409C1E82C2664B0D4C3B511701624702B2E2A3/VC_redist.x64.exe'
  Checksum64 = 'a1592d3da2b27230c087a3b069409c1e82c2664b0d4c3b511701624702b2e2a3'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.29.30037'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
