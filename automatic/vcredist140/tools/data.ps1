$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/285b28c7-3cf9-47fb-9be8-01cf5323a8df/C4E3992F3883005881CF3937F9E33F1C7D792AC1C860EA9C52D8F120A16A7EB1/VC_redist.x86.exe'
  Checksum = 'c4e3992f3883005881cf3937f9e33f1c7d792ac1c860ea9c52d8f120a16a7eb1'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/285b28c7-3cf9-47fb-9be8-01cf5323a8df/8F9FB1B3CFE6E5092CF1225ECD6659DAB7CE50B8BF935CB79BFEDE1F3C895240/VC_redist.x64.exe'
  Checksum64 = '8f9fb1b3cfe6e5092cf1225ecd6659dab7ce50b8bf935cb79bfede1f3c895240'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.42.34438'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
