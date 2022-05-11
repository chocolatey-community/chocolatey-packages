$installData32 = @{
  Url = 'https://download.visualstudio.microsoft.com/download/pr/06ed1d94-3f28-47a5-8025-e7bf9da634da/2ACBFE92157C1CF1A7B524A9325824046D83DBFA3FEB1CBD4DD02A42E020F77C/VC_redist.x86.exe'
  Checksum = '2acbfe92157c1cf1a7b524a9325824046d83dbfa3feb1cbd4dd02a42e020f77c'
  ChecksumType = 'sha256'
}

$installData64 = @{
  Url64 = 'https://download.visualstudio.microsoft.com/download/pr/6b6923b0-3045-4379-a96f-ef5506a65d5b/426A34C6F10EA8F7DA58A8C976B586AD84DD4BAB42A0CFDBE941F1763B7755E5/VC_redist.x64.exe'
  Checksum64 = '426a34c6f10ea8f7da58a8c976b586ad84dd4bab42a0cfdbe941f1763b7755e5'
  ChecksumType64 = 'sha256'
}

$uninstallData = @{
  SoftwareName = 'Microsoft Visual C++ 2015-2022 Redistributable*'
}

$otherData = @{
  ThreePartVersion = [version]'14.32.31326'
  FamilyRegistryKey = '14.0'
  PackageName = 'vcredist140'
}
