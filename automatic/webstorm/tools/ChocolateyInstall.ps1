$ErrorActionPreference  = 'Stop'

$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'JetBrains WebStorm*'
    url                 = 'https://download.jetbrains.com/webstorm/WebStorm-2018.1.3.exe'
    checksum            = '3af0a9eb90a1f2c1767224280c4f3767eaef526da559a94b7c18306008ca3b48'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/S'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
