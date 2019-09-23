$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/9565895b-35a6-434b-a881-11a6f4beec76/4A8157B2FF422C259DDAA2D0E568C0C0AFAB940E1F6E0E482EF83E90DDBAD2D6/VC_redist.x86.exe'
  Checksum = '4a8157b2ff422c259ddaa2d0e568c0c0afab940e1f6e0e482ef83e90ddbad2d6'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/9565895b-35a6-434b-a881-11a6f4beec76/EE84FED2552E018E854D4CD2496DF4DD516F30733A27901167B8A9882119E57C/VC_redist.x64.exe'
  Checksum64 = 'ee84fed2552e018e854d4cd2496df4dd516f30733a27901167b8a9882119e57c'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.23.27820'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
