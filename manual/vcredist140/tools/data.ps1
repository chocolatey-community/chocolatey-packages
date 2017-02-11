$installData32 = @{
  Url = 'https://download.microsoft.com/download/e/a/6/ea646852-2721-4a68-b22c-a02a45913b7e/vc_redist.x86.exe'
  Checksum = 'AA7C24816BCEB5A99DD2F952ADB8330ED7857145B4FA8ABD1B38AA0DF8E89EBE'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.microsoft.com/download/4/f/1/4f11cabd-32b5-4d53-8807-58448405f899/vc_redist.x64.exe'
  Checksum64 = '526D5547CF177FDDD5EFA8F275DC8064607A9B385CC7236274519430613E473F'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2017 RC Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.10.24930'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
