$installData32 = @{
    Url = 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe'
    Checksum = 'FDD1E1F0DCAE2D0AA0720895EFF33B927D13076E64464BB7C7E5843B7667CD14'
    ChecksumType = 'sha256'
}

$installData64 = @{
    Url64 = 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe'
    Checksum64 = '5EEA714E1F22F1875C1CB7B1738B0C0B1F02AEC5ECB95F0FDB1C5171C6CD93A3'
    ChecksumType64 = 'sha256'
}

$uninstallData = @{
    SoftwareName = 'Microsoft Visual C++ 2015 Redistributable*'
}
