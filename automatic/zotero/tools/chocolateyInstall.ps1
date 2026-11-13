$ErrorActionPreference = 'Stop'

$url32 = 'https://download.zotero.org/client/release/10.0.8/Zotero-10.0.8_win32_setup.exe'
$url64 = 'https://download.zotero.org/client/release/10.0.8/Zotero-10.0.8_x64_setup.exe'

$checksum32 = '69018a0eac1f01a4e474d395af96e36da12fbd57ee82eca31327e13bc9dd8105'
$checksum64 = '1ba5d091fd24b50db1159c71650f55303d99c82e66494dc09eddab76a4179d73'

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
