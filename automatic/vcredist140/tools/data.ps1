$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/e9e1e87c-5bba-49fa-8bad-e00f0527f9bc/8e641901c2257dda7f0d3fd26541e07a/vc_redist.x86.exe'
  Checksum = '7355962b95d6a5441c304cd2b86baf37bc206f63349f4a02289bcfb69ef142d3'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/36c5faaf-bd8b-433f-b3d7-2af73bae10a8/212f41f2ccffee6d6dc27f901b7d77a1/vc_redist.x64.exe'
  Checksum64 = 'b192e143d55257a0a2f76be42e44ff8ee14014f3b1b196c6e59829b6b3ec453c'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.16.27027'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
