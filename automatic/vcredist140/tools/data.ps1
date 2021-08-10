$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/221ed2ae-1269-497b-a962-e113045001fa/1ACD8D5EA1CDC3EB2EB4C87BE3AB28722D0825C15449E5C9CEEF95D897DE52FA/VC_redist.x86.exe'
  Checksum = '1acd8d5ea1cdc3eb2eb4c87be3ab28722d0825c15449e5c9ceef95d897de52fa'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/7239cdc3-bd73-4f27-9943-22de059a6267/003063723B2131DA23F40E2063FB79867BAE275F7B5C099DBD1792E25845872B/VC_redist.x64.exe'
  Checksum64 = '003063723b2131da23f40e2063fb79867bae275f7b5c099dbd1792e25845872b'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.29.30133'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
