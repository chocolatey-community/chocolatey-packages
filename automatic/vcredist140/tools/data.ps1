$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/6f02464a-5e9b-486d-a506-c99a17db9a83/E7267C1BDF9237C0B4A28CF027C382B97AA909934F84F1C92D3FB9F04173B33E/VC_redist.x86.exe'
  Checksum = 'e7267c1bdf9237c0b4a28cf027c382b97aa909934f84f1c92d3fb9f04173b33e'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/6f02464a-5e9b-486d-a506-c99a17db9a83/8995548DFFFCDE7C49987029C764355612BA6850EE09A7B6F0FDDC85BDC5C280/VC_redist.x64.exe'
  Checksum64 = '8995548dfffcde7c49987029c764355612ba6850ee09a7b6f0fddc85bdc5c280'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2026 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.50.35719'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
