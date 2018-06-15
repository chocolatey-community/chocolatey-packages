$ErrorActionPreference  = 'Stop'

$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'JetBrains WebStorm*'
    url                 = 'https://download.jetbrains.com/webstorm/WebStorm-2018.1.5.exe'
    checksum            = '5c3d1f3ab2bc6ace7a28d3339edf80e797e3cc33403735960911cc02377495e8'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/S'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
