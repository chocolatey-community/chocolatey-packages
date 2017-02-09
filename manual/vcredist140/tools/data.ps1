$installData32 = @{
    Url = 'https://download.microsoft.com/download/9/a/2/9a2a7e36-a8af-46c0-8a78-a5eb111eefe2/vc_redist.x86.exe'
    Checksum = 'DAFB8B5F4B46BFAF7FAA1D0AD05211F5C9855F0005CD603F8B5037B6A708D6B6'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/2/a/2/2a2ef9ab-1b4b-49f0-9131-d33f79544e70/vc_redist.x64.exe'
    Checksum64 = 'D7257265DBC0635C96DD67DDF938A09ABE0866CB2D4FA05F8B758C8644E724E4'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ 2015 Redistributable*'
}

$otherData = @{
    ThreePartVersion = [version]'14.0.24212'
    FamilyRegistryKey = '14.0'
    PackageName = 'vcredist140'
}
