$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/40b59c73-1480-4caf-ab5b-4886f176bf71/435A0DE411B991E2BFC7FD1D5439639E7B32206960D3099370E36172018F52FE/VC_redist.x86.exe'
  Checksum = '435a0de411b991e2bfc7fd1d5439639e7b32206960d3099370e36172018f52fe'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/40b59c73-1480-4caf-ab5b-4886f176bf71/D62841375B90782B1829483AC75695CCEF680A8F13E7DE569B992EF33C6CD14A/VC_redist.x64.exe'
  Checksum64 = 'd62841375b90782b1829483ac75695ccef680a8f13e7de569b992ef33c6cd14a'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.44.35208'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
