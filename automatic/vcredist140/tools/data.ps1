$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/d60aa805-26e9-47df-b4e3-cd6fcc392333/A06AAC66734A618AB33C1522920654DDFC44FC13CAFAA0F0AB85B199C3D51DC0/VC_redist.x86.exe'
  Checksum = 'a06aac66734a618ab33c1522920654ddfc44fc13cafaa0f0ab85b199c3d51dc0'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/d60aa805-26e9-47df-b4e3-cd6fcc392333/7D7105C52FCD6766BEEE1AE162AA81E278686122C1E44890712326634D0B055E/VC_redist.x64.exe'
  Checksum64 = '7d7105c52fcd6766beee1ae162aa81e278686122c1e44890712326634d0b055e'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.26.28720'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
