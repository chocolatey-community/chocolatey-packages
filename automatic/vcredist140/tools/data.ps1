$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/348da5f2-c5d4-4fbf-8360-d1b907780672/E59AE3E886BD4571A811FE31A47959AE5C40D87C583F786816C60440252CD7EC/VC_redist.x86.exe'
  Checksum = 'e59ae3e886bd4571a811fe31a47959ae5c40d87c583f786816c60440252cd7ec'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/3b070396-b7fb-4eee-aa8b-102a23c3e4f4/40EA2955391C9EAE3E35619C4C24B5AAF3D17AEAA6D09424EE9672AA9372AEED/VC_redist.x64.exe'
  Checksum64 = '40ea2955391c9eae3e35619c4c24b5aaf3d17aeaa6d09424ee9672aa9372aeed'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.24.28127.4'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
