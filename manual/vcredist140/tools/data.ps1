$installData32 = @{
    Url = 'https://download.microsoft.com/download/e/4/b/e4bed790-c499-4104-a6d2-f03caa54f9ee/vc_redist.x86.exe'
    Checksum = '0A8F90C5DAAF955099C291F0BA9D3B2289B81436DA1E53B2B48673D38B6D7A86'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/9/5/7/9577e0f2-cabd-4b10-bbcf-24ec798c78fe/vc_redist.x64.exe'
    Checksum64 = 'C7F1978B2CA7F9E243C1DD849B2F78DAB5BADA54B440162AC2E926D6F8367D70'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ 2017 RC Redistributable*'
}

$otherData = @{
    ThreePartVersion = [version]'14.10.24911'
    FamilyRegistryKey = '14.0'
    PackageName = 'vcredist140'
}
