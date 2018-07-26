$ErrorActionPreference  = 'Stop'

$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'JetBrains DataGrip*'
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2018.2.exe'
    checksum            = '6453b0d3afe1420208e042d2eea7845a90aaf989c8a77962e43f50074a139949'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/S'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
