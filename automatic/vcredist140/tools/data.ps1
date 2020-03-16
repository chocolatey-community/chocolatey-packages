$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/8c211be1-c537-4402-82e7-a8fb5ee05e8a/AC96016F1511AE3EB5EC9DE04551146FE351B7F97858DCD67163912E2302F5D6/VC_redist.x86.exe'
  Checksum = 'ac96016f1511ae3eb5ec9de04551146fe351b7f97858dcd67163912e2302f5d6'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/8c211be1-c537-4402-82e7-a8fb5ee05e8a/B6C82087A2C443DB859FDBEAAE7F46244D06C3F2A7F71C35E50358066253DE52/VC_redist.x64.exe'
  Checksum64 = 'b6c82087a2c443db859fdbeaae7f46244d06c3f2a7f71c35e50358066253de52'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.25.28508'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
