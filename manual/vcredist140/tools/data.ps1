$installData32 = @{
    Url = 'https://download.microsoft.com/download/e/6/6/e66c5871-7afe-4640-a454-786eabe8aae8/vc_redist.x86.exe'
    Checksum = 'FDCCB907365A76E94B9DDC36538A35709688528F03283047F660AA2CB9BCBB1A'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/7/2/5/72572684-052f-4aa9-9170-9d40813a87be/vc_redist.x64.exe'
    Checksum64 = 'DBD2A04C202214181E2D7E0618F4B3B88DDFE690C97338A45CA3038DAA4ADBA2'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ vNext Redistributable*'
}

$otherData = @{
    ThreePartVersion = [version]'14.10.24629'
    FamilyRegistryKey = '14.0'
    PackageName = 'vcredist140'
}
