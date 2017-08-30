$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/11100229/78c1e864d806e36f6035d80a0e80399e/VC_redist.x86.exe'
  Checksum = '2DA11E22A276BE85970EAED255DAF3D92AF84E94142EC04252326A882E57303E'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/11100230/15ccb3f02745c7b206ad10373cbca89b/VC_redist.x64.exe'
  Checksum64 = '7434BF559290CCCC3DD3624F10C9E6422CCE9927D2231D294114B2F929F0E465'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2017 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.11.25325'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
