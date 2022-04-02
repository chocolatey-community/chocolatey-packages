$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/2b5bcd2f-0dbc-4b83-90a3-3b1c5ae77e62/0252474394129dbab6ff9ce24f1c6a3c/vc_redist.x86.exe'
  Checksum = '54ad46ae80984aa48cae6361213692c96b3639e322730d28c7fb93b183c761da'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/4100b84d-1b4d-487d-9f89-1354a7138c8f/5B0CBB977F2F5253B1EBE5C9D30EDBDA35DBD68FB70DE7AF5FAAC6423DB575B5/VC_redist.x64.exe'
  Checksum64 = '5b0cbb977f2f5253b1ebe5c9d30edbda35dbd68fb70de7af5faac6423db575b5'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2017 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.16.27033'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
