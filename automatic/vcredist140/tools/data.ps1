$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/6ea9376d-6ab0-45ac-a305-d76274c006ed/6a1eef0ca6e0de1c1b41b6202d2208b2/vc_redist.x86.exe'
  Checksum = '32907e5cb270b2e6733a21cd45bb059a6cdd22517c56b2fc93529bdb8e4d6f2b'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/46db022e-06ea-4d11-a724-d26d33bc63f7/2b635c854654745078d5577a8ed0f80d/vc_redist.x64.exe'
  Checksum64 = '0cf2fe188d98330ee11b7a7a151cb87b44e2f3b30a4b6f8cd3735e0f9118d606'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2017 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.16.27024'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
