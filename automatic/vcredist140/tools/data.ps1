$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/9c69db26-cda4-472d-bdae-f2b87f4a0177/A32DD41EAAB0C5E1EAA78BE3C0BB73B48593DE8D97A7510B97DE3FD993538600/VC_redist.x86.exe'
  Checksum = 'a32dd41eaab0c5e1eaa78be3c0bb73b48593de8d97a7510b97de3fd993538600'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/1754ea58-11a6-44ab-a262-696e194ce543/3642E3F95D50CC193E4B5A0B0FFBF7FE2C08801517758B4C8AEB7105A091208A/VC_redist.x64.exe'
  Checksum64 = '3642e3f95d50cc193e4b5a0b0ffbf7fe2c08801517758b4c8aeb7105a091208a'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.40.33810'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
