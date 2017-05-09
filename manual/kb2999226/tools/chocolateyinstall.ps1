$msuData = @{
  '6.0-client' = @{
    Url = 'https://download.microsoft.com/download/D/8/3/D838D576-232C-4C17-A402-75913F27113B/Windows6.0-KB2999226-x86.msu'
    Url64 = 'https://download.microsoft.com/download/5/4/E/54E27BE2-CFB2-4FC9-AB03-C39302CA68A0/Windows6.0-KB2999226-x64.msu'
    Checksum = 'AE380F63BF4E8700ADA686406B04B01230A339B09EDF7819814A4C0BF4AB72E1'
    Checksum64 = '10069DE7315CA3F405E2579846AF5DAB3089A8496AE4C1AB61763480F43A05A8'
  }
  '6.0-server' = @{
    Url = 'https://download.microsoft.com/download/B/5/7/B5757251-DAB0-4E23-AA46-ABC233FDB90E/Windows6.0-KB2999226-x86.msu'
    Url64 = 'https://download.microsoft.com/download/A/7/A/A7A70B17-ADF9-4FC3-A722-69FA89B79756/Windows6.0-KB2999226-x64.msu'
    Checksum = 'AE380F63BF4E8700ADA686406B04B01230A339B09EDF7819814A4C0BF4AB72E1'
    Checksum64 = '10069DE7315CA3F405E2579846AF5DAB3089A8496AE4C1AB61763480F43A05A8'
  }
  '6.1-client' = @{
    Url = 'https://download.microsoft.com/download/4/F/E/4FE73868-5EDD-4B47-8B33-CE1BB7B2B16A/Windows6.1-KB2999226-x86.msu'
    Url64 = 'https://download.microsoft.com/download/1/1/5/11565A9A-EA09-4F0A-A57E-520D5D138140/Windows6.1-KB2999226-x64.msu'
    Checksum = '909E76C81EF0EB176144B253DDFFE7A8FDFACEBFAA15E97DEF003D2262FBF084'
    Checksum64 = '43234D2986CA9B0DE75D5183977964D161A8395C3396279DDFC9B20698E5BC34'
  }
  '6.1-server' = @{
    Url64 = 'https://download.microsoft.com/download/F/1/3/F13BEC9A-8FC6-4489-9D6A-F84BDC9496FE/Windows6.1-KB2999226-x64.msu'
    Checksum64 = '43234D2986CA9B0DE75D5183977964D161A8395C3396279DDFC9B20698E5BC34'
  }
  '6.2-client' = @{
    Url = 'https://download.microsoft.com/download/1/E/8/1E8AFE90-5217-464D-9292-7D0B95A56CE4/Windows8-RT-KB2999226-x86.msu'
    Url64 = 'https://download.microsoft.com/download/A/C/1/AC15393F-A6E6-469B-B222-C44B3BB6ECCC/Windows8-RT-KB2999226-x64.msu'
    Checksum = '0F36750FBB06FEE23131F68B4D0943841EED24730EC1D5D77DEDC41D359BE88D'
    Checksum64 = '50CAE25DA33FA950222D1A803E42567291EB7FEB087FA119B1C97FE9D41CD9F8'
  }
  '6.2-server' = @{
    Url64 = 'https://download.microsoft.com/download/9/3/E/93E0745A-EAE9-4B5A-B50C-012F2D3B6659/Windows8-RT-KB2999226-x64.msu'
    Checksum64 = '50CAE25DA33FA950222D1A803E42567291EB7FEB087FA119B1C97FE9D41CD9F8'
  }
  '6.3-client' = @{
    Url = 'https://download.microsoft.com/download/E/4/6/E4694323-8290-4A08-82DB-81F2EB9452C2/Windows8.1-KB2999226-x86.msu'
    Url64 = 'https://download.microsoft.com/download/9/6/F/96FD0525-3DDF-423D-8845-5F92F4A6883E/Windows8.1-KB2999226-x64.msu'
    Checksum = 'B83251219C5390536B02BEBAF5E43A6F13381CE1DB43E76483BCE07C4BCF877B'
    Checksum64 = '9F707096C7D279ED4BC2A40BA695EFAC69C20406E0CA97E2B3E08443C6381D15'
  }
  '6.3-server' = @{
    Url64 = 'https://download.microsoft.com/download/D/1/3/D13E3150-3BB2-4B22-9D8A-47EE2D609FFF/Windows8.1-KB2999226-x64.msu'
    Checksum64 = '9F707096C7D279ED4BC2A40BA695EFAC69C20406E0CA97E2B3E08443C6381D15'
  }
}

$servicePackRequirements = @{
  '6.0' = @{ ServicePackNumber = 1; ChocolateyPackage = $null }
  '6.1' = @{ ServicePackNumber = 1; ChocolateyPackage = 'KB976932' }
}

Install-WindowsUpdate -Id 'KB2999226' -MsuData $msuData -ChecksumType 'sha256' -ServicePackRequirements $servicePackRequirements
