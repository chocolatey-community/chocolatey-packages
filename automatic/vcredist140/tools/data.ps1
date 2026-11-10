$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/78d061c5-9ef3-42ab-98ed-3309d1095dc4/7B0117E6E20E9E349029C000A8A2715A52CF37C15B6BB697B2908E8BC7066CDF/VC_redist.x86.exe'
  Checksum = '7b0117e6e20e9e349029c000a8a2715a52cf37c15b6bb697b2908e8bc7066cdf'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/78d061c5-9ef3-42ab-98ed-3309d1095dc4/9C02C9ED120F671B900E6B9471D890E3B2414117A7E53F4AE2E855466FA2B7C9/VC_redist.x64.exe'
  Checksum64 = '9c02c9ed120f671b900e6b9471d890e3b2414117a7e53f4ae2e855466fa2b7c9'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2026 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.52.37029'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
