$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/100349138/88b50ce70017bf10f2d56d60fcba6ab1/VC_redist.x86.exe'
  Checksum = 'e7d34f0a9d37d7221adc911bd49b316de68a75f3bfa910e2550849ad13d0573f'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/100349091/2cd2dba5748dc95950a5c42c2d2d78e4/VC_redist.x64.exe'
  Checksum64 = '52dcfaf0c7cf62c333e12457339a581ac369e06576f93ded45ac002a1b3621fb'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2017 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.12.25810'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
