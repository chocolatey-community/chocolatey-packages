$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/71c6392f-8df5-4b61-8d50-dba6a525fb9d/510FC8C2112E2BC544FB29A72191EABCC68D3A5A7468D35D7694493BC8593A79/VC_redist.x86.exe'
  Checksum = '510fc8c2112e2bc544fb29a72191eabcc68d3a5a7468d35d7694493bc8593a79'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/6ba404bb-6312-403e-83be-04b062914c98/1AD7988C17663CC742B01BEF1A6DF2ED1741173009579AD50A94434E54F56073/VC_redist.x64.exe'
  Checksum64 = '1ad7988c17663cc742b01bef1a6df2ed1741173009579ad50a94434e54f56073'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.38.33135'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
