$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/144a5711-f076-44fa-bf55-f7e0121eb30c/B7AE307237F869E09F7413691A2CD1944357B5CEE28049C0A0D3430B47BB3EDC/VC_redist.x86.exe'
  Checksum = 'b7ae307237f869e09f7413691a2cd1944357b5cee28049c0a0d3430b47bb3edc'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/d22ecb93-6eab-4ce1-89f3-97a816c55f04/37ED59A66699C0E5A7EBEEF7352D7C1C2ED5EDE7212950A1B0A8EE289AF4A95B/VC_redist.x64.exe'
  Checksum64 = '37ed59a66699c0e5a7ebeef7352d7c1c2ed5ede7212950a1b0a8ee289af4a95b'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.31.31103'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
