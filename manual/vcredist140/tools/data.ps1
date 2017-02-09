$installData32 = @{
    Url = 'https://download.microsoft.com/download/C/E/5/CE514EAE-78A8-4381-86E8-29108D78DBD4/VC_redist.x86.exe'
    Checksum = '4FF07492947C3E52607AA8DE0C241898AA35C439C442DE1CEA5D17DE5B7C7F01'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/C/E/5/CE514EAE-78A8-4381-86E8-29108D78DBD4/VC_redist.x64.exe'
    Checksum64 = '4504CD3BBCCDD7EFB9EC68261D57A04C2C8D704812C56856F4786AC90F7F00A8'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ 2015 Redistributable*'
}

$otherData = @{
    ThreePartVersion = [version]'14.0.23506'
    FamilyRegistryKey = '14.0'
    PackageName = 'vcredist140'
}
