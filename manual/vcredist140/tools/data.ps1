$installData32 = @{
  Url = 'https://download.microsoft.com/download/1/f/e/1febbdb2-aded-4e14-9063-39fb17e88444/vc_redist.x86.exe'
  Checksum = '54133DC6E13D775199BBEC9268AE5E54063F9C6CB7B630F7865704CC64F50774'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.microsoft.com/download/3/b/f/3bf6e759-c555-4595-8973-86b7b4312927/vc_redist.x64.exe'
  Checksum64 = '871983B6B4C3BCE1B5B9AE2173C818137C8831C818393268FB2F0414C096E241'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2017 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.10.25017'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
