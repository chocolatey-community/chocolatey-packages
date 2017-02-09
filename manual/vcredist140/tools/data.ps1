$installData32 = @{
    Url = 'https://download.microsoft.com/download/f/3/9/f39b30ec-f8ef-4ba3-8cb4-e301fcf0e0aa/vc_redist.x86.exe'
    Checksum = '91CBE41DAA3625EBBE2F3F8E18CC9F4D1C2660698D307935D9CC5DF4F98E91C6'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/4/c/b/4cbd5757-0dd4-43a7-bac0-2a492cedbacb/vc_redist.x64.exe'
    Checksum64 = '5636B05C1755EDC21BFF892C46EA2240F30742F45A11832E34EF73B6EE2B0A82'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ 2015 Redistributable*'
}

$otherData = @{
    ThreePartVersion = [version]'14.0.23918'
    FamilyRegistryKey = '14.0'
    PackageName = 'vcredist140'
}
