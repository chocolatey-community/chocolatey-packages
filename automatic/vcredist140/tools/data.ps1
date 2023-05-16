$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/eaab1f82-787d-4fd7-8c73-f782341a0c63/5365A927487945ECB040E143EA770ADBB296074ECE4021B1D14213BDE538C490/VC_redist.x86.exe'
  Checksum = '5365a927487945ecb040e143ea770adbb296074ece4021b1d14213bde538c490'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/eaab1f82-787d-4fd7-8c73-f782341a0c63/917C37D816488545B70AFFD77D6E486E4DD27E2ECE63F6BBAAF486B178B2B888/VC_redist.x64.exe'
  Checksum64 = '917c37d816488545b70affd77d6e486e4dd27e2ece63f6bbaaf486b178b2b888'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.36.32532'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
