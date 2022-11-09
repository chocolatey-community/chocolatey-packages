$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/6a4c74cd-8ee0-4757-9620-a11a5b48b1a7/CE4843A946EE3732EB2BFC098DB5741DC5495C7BEA204E11D379336DCC68E875/VC_redist.x86.exe'
  Checksum = 'ce4843a946ee3732eb2bfc098db5741dc5495c7bea204e11d379336dcc68e875'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/bcb0cef1-f8cb-4311-8a5c-650a5b694eab/2257B3FBE3C7559DE8B31170155A433FAF5B83829E67C589D5674FF086B868B9/VC_redist.x64.exe'
  Checksum64 = '2257b3fbe3c7559de8b31170155a433faf5b83829e67c589d5674ff086b868b9'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.34.31931'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
