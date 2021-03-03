$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/d64b93c3-f270-4750-9e75-bc12b2e899fb/4521ED84B9B1679A706E719423D54EF5E413DC50DDE1CF362232D7359D7E89C4/VC_redist.x86.exe'
  Checksum = '4521ed84b9b1679a706e719423d54ef5e413dc50dde1cf362232d7359d7e89c4'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/cd3a705f-70b6-46f7-b8e2-63e6acc5bd05/F299953673DE262FEFAD9DD19BFBE6A5725A03AE733BEBFEC856F1306F79C9F7/VC_redist.x64.exe'
  Checksum64 = 'f299953673de262fefad9dd19bfbe6a5725a03ae733bebfec856f1306f79c9f7'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.28.29910'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
