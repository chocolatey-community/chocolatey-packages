$ErrorActionPreference  = 'Stop'

$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'JetBrains DataGrip*'
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2017.1.4.exe'
    checksum            = '8ec99e69dbc5e2fcbf2c9d7e4c88e4be390c08970799eceae4341c00062884fb'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/S'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
