$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/0dd156af-82aa-4812-b524-49c2f894359a/B6AB675F0A27E6600F9726E75DEA08D99C15F8EA4B842A2A1D988FA9529D39B9/VC_redist.x86.exe'
  Checksum = 'b6ab675f0a27e6600f9726e75dea08d99c15f8ea4b842a2a1d988fa9529d39b9'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/c1bd4f2c-3672-468e-8480-7ed419dbb641/90E48ADE404E4576D023ABFA374F323555F233982A8805EA9AC63DCA9491A16B/VC_redist.x64.exe'
  Checksum64 = '90e48ade404e4576d023abfa374f323555f233982a8805ea9ac63dca9491a16b'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2026 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.51.36231'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
