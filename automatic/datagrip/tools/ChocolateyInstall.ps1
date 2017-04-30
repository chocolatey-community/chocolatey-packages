$ErrorActionPreference  = 'Stop'

$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'JetBrains DataGrip*'
    url                 = 'https://download.jetbrains.com/datagrip/datagrip-2017.1.2.exe'
    checksum            = '30743f86a7cd9043cfe158f6be28387e1fd9263da2d018659879b379140ecde0'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/S'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
