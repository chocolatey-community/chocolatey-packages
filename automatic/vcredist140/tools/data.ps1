$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/5319f718-2a84-4aff-86be-8dbdefd92ca1/DD1A8BE03398367745A87A5E35BEBDAB00FDAD080CF42AF0C3F20802D08C25D4/VC_redist.x86.exe'
  Checksum = 'dd1a8be03398367745a87a5e35bebdab00fdad080cf42af0c3f20802d08c25d4'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/c7dac50a-e3e8-40f6-bbb2-9cc4e3dfcabe/1821577409C35B2B9505AC833E246376CC68A8262972100444010B57226F0940/VC_redist.x64.exe'
  Checksum64 = '1821577409c35b2b9505ac833e246376cc68a8262972100444010b57226f0940'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.42.34433'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
