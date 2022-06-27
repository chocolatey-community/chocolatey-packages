$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/ed95ef9e-da02-4735-9064-bd1f7f69b6ed/CF92A10C62FFAB83B4A2168F5F9A05E5588023890B5C0CC7BA89ED71DA527B0F/VC_redist.x86.exe'
  Checksum = 'cf92a10c62ffab83b4a2168f5f9a05e5588023890b5c0cc7ba89ed71da527b0f'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/ed95ef9e-da02-4735-9064-bd1f7f69b6ed/CE6593A1520591E7DEA2B93FD03116E3FC3B3821A0525322B0A430FAA6B3C0B4/VC_redist.x64.exe'
  Checksum64 = 'ce6593a1520591e7dea2b93fd03116e3fc3b3821a0525322b0a430faa6b3c0b4'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.32.31332'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
