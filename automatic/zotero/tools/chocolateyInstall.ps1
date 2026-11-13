$ErrorActionPreference = 'Stop'

$url32 = 'https://download.zotero.org/client/release/10.0.8/Zotero-10.0.8_win32_setup.exe'
$url64 = 'https://download.zotero.org/client/release/10.0.8/Zotero-10.0.8_x64_setup.exe'

$checksum32 = '69018A0EAC1F01A4E474D395AF96E36DA12FBD57EE82ECA31327E13BC9DD8105'
$checksum64 = '1BA5D091FD24B50DB1159C71650F55303D99C82E66494DC09EDDAB76A4179D73'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'Zotero*'
    fileType       = 'exe'
    url            = $url32
    url64bit       = $url64
    checksum       = $checksum32
    checksum64     = $checksum64
    checksumType   = 'sha256'
    checksumType64 = 'sha256'
    silentArgs     = '/S'
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs