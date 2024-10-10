$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/5cc0a375-ebc5-4a27-8a76-aa43097a8949/ED1967C2AC27D806806D121601B526F84E497AE1B99ED139C0C4C6B50147DF4A/VC_redist.x86.exe'
  Checksum = 'ed1967c2ac27d806806d121601b526f84e497ae1b99ed139c0c4c6b50147df4a'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/368cc6bf-087b-49f9-93e6-ab05b70a58e0/814E9DA5EC5E5D6A8FA701999D1FC3BADDF7F3ADC528E202590E9B1CB73E4A11/VC_redist.x64.exe'
  Checksum64 = '814e9da5ec5e5d6a8fa701999d1fc3baddf7f3adc528e202590e9b1cb73e4a11'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.40.33816'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
