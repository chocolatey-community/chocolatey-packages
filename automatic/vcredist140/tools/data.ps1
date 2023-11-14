$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/a061be25-c14a-489a-8c7c-bb72adfb3cab/C61CEF97487536E766130FA8714DD1B4143F6738BFB71806018EEE1B5FE6F057/VC_redist.x86.exe'
  Checksum = 'c61cef97487536e766130fa8714dd1b4143f6738bfb71806018eee1b5fe6f057'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/a061be25-c14a-489a-8c7c-bb72adfb3cab/4DFE83C91124CD542F4222FE2C396CABEAC617BB6F59BDCBDF89FD6F0DF0A32F/VC_redist.x64.exe'
  Checksum64 = '4dfe83c91124cd542f4222fe2c396cabeac617bb6f59bdcbdf89fd6f0df0a32f'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.38.33130'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
