$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/48431a06-59c5-4b63-a102-20b66a521863/CAA38FD474164A38AB47AC1755C8CCCA5CCFACFA9A874F62609E6439924E87EC/VC_redist.x86.exe'
  Checksum = 'caa38fd474164a38ab47ac1755c8ccca5ccfacfa9a874f62609e6439924e87ec'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/48431a06-59c5-4b63-a102-20b66a521863/4B5890EB1AEFDF8DFA3234B5032147EB90F050C5758A80901B201AE969780107/VC_redist.x64.exe'
  Checksum64 = '4b5890eb1aefdf8dfa3234b5032147eb90f050c5758a80901b201ae969780107'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2019 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.27.29112'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
