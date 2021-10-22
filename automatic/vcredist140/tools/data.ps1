$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/10a8d53a-c69e-4586-8c6b-c416bf85a0ae/AC75A82D873E6B6F98B1D293042380764D7D263C43438E50D564FA58C9F891C2/VC_redist.x86.exe'
  Checksum = 'ac75a82d873e6b6f98b1d293042380764d7d263c43438e50d564fa58c9f891c2'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/10a8d53a-c69e-4586-8c6b-c416bf85a0ae/A9F5D2EAF67BF0DB0178B6552A71C523C707DF0E2CC66C06BFBC08BDC53387E7/VC_redist.x64.exe'
  Checksum64 = 'a9f5d2eaf67bf0db0178b6552a71c523c707df0e2cc66c06bfbc08bdc53387e7'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.30.30704'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
