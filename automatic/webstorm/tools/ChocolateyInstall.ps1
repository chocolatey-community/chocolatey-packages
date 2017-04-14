$ErrorActionPreference  = 'Stop'
$downloadDir            = Get-PackageCacheLocation
$installer              = 'WebStorm-2017.1.1.exe'
$arguments              = @{
    packageName         =  $env:ChocolateyPackageName
    softwareName        = 'WebStorm'
    file                = Join-Path $downloadDir $installer
    url                 = 'https://download.jetbrains.com/webstorm/WebStorm-2017.1.1.exe'
    checksum            = '794D23C1E0947C330EE2B6CFB0AF17AB62DBCFA6FFF83B2439AB3B6114F87B48'
    fileType            = 'exe'
    checksumType        = 'sha256'
    silentArgs          = '/S'
    validExitCodes      = @(0, 1641, 3010)
}

Install-ChocolateyPackage @arguments
