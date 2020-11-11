$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/8ecb9800-52fd-432d-83ee-d6e037e96cc2/50A3E92ADE4C2D8F310A2812D46322459104039B9DEADBD7FDD483B5C697C0C8/VC_redist.x86.exe'
  Checksum = '50a3e92ade4c2d8f310a2812d46322459104039b9deadbd7fdd483b5c697c0c8'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/89a3b9df-4a09-492e-8474-8f92c115c51d/B1A32C71A6B7D5978904FB223763263EA5A7EB23B2C44A0D60E90D234AD99178/VC_redist.x64.exe'
  Checksum64 = 'b1a32c71a6b7d5978904fb223763263ea5a7eb23b2c44a0d60e90d234ad99178'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.28.29325'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
