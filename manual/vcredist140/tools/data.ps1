$installData32 = @{
    Url = 'https://download.microsoft.com/download/4/5/6/456cf79a-4046-4232-8e6f-7cf3d8075d9a/vc_redist.x86.exe'
    Checksum = 'A8A60D9C23AE708FEA0D7D757E4757EDAFEB80BCC0596A54D8C5DF426701352F'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/8/5/e/85edb843-93af-4daa-ad1e-c33dfa95b2ea/vc_redist.x64.exe'
    Checksum64 = 'E8E1896B0E0F608E183B90D4CBC086AF638067C57C0368BB20E49E209DCA678F'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ 2015 Redistributable*'
}

$otherData = @{
    ThreePartVersion = [version]'14.0.24516'
    FamilyRegistryKey = '14.0'
    PackageName = 'vcredist140'
}
