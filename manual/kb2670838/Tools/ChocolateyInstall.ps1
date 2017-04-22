$msuData = @{
  '6.1-client' = @{
    Url = 'https://download.microsoft.com/download/1/4/9/14936FE9-4D16-4019-A093-5E00182609EB/Windows6.1-KB2670838-x86.msu'
    Url64 = 'https://download.microsoft.com/download/1/4/9/14936FE9-4D16-4019-A093-5E00182609EB/Windows6.1-KB2670838-x64.msu'
    Checksum = 'a43037dd15993273e6dd7398345e2bd0424225be81eb8acfaa1361442ef56fce'
    Checksum64 = '9fe71e7dcd2280ce323880b075ade6e56c49b68fc702a9b4c0a635f0f1fb9db8'
  }

  '6.1-server' = @{
    Url64 = 'https://download.microsoft.com/download/1/4/9/14936FE9-4D16-4019-A093-5E00182609EB/Windows6.1-KB2670838-x64.msu'
    Checksum64 = '9fe71e7dcd2280ce323880b075ade6e56c49b68fc702a9b4c0a635f0f1fb9db8'
  }
}

$servicePackRequirements = @{
  '6.1' = @{ ServicePackNumber = 1; ChocolateyPackage = 'KB976932' }
}

Install-WindowsUpdate -Id 'KB2670838' -MsuData $msuData -ChecksumType 'sha256' -ServicePackRequirements $servicePackRequirements
