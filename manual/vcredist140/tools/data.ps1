$installData32 = @{
    Url = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe'
    Checksum = '12A69AF8623D70026690BA14139BF3793CC76C865759CAD301B207C1793063ED'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'
    Checksum64 = 'DA66717784C192F1004E856BBCF7B3E13B7BF3EA45932C48E4C9B9A50CA80965'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ 2015 Redistributable*'
}

$otherData = @{
    ThreePartVersion = [version]'14.0.24215'
    FamilyRegistryKey = '14.0'
    PackageName = 'vcredist140'
}
