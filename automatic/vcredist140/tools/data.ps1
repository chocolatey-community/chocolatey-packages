$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/888b4c07-c602-499a-9efb-411188496ce7/F3A86393234099BEDD558FD35AB538A6E4D9D4F99AD5ADFA13F603D4FF8A42DC/VC_redist.x86.exe'
  Checksum = 'f3a86393234099bedd558fd35ab538a6e4d9d4f99ad5adfa13f603d4ff8a42dc'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/36e45907-8554-4390-ba70-9f6306924167/97CC5066EB3C7246CF89B735AE0F5A5304A7EE33DC087D65D9DFF3A1A73FE803/VC_redist.x64.exe'
  Checksum64 = '97cc5066eb3c7246cf89b735ae0f5a5304a7ee33dc087d65d9dff3a1a73fe803'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.29.30040'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
