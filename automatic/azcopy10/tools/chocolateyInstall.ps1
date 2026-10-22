$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.34.1/azcopy_windows_amd64_10.34.1.zip'
    checksum64     = '6d299fdf2dbf466167e9806576d15cb0de3c4ce8769caf5d1c1110877e5f66ff'
    checksumType64 = 'sha256'
    url            = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.34.1/azcopy_windows_386_10.34.1.zip'
    checksum       = '3b074f386135d085c1cae500757b874a390d41f1644fea4c630370860b9d0178'
    checksumType   = 'sha256'
    destination    = $toolsDir
}

#Manage azcopy installation
Install-ChocolateyZipPackage @packageArgs

$targetPath = Join-Path -Path $toolsDir -ChildPath 'azcopy'
If (Test-Path -Path $targetPath -PathType:Container) {
    Remove-Item -Path $targetPath -Force -Recurse
}

Get-ChildItem -Path $toolsDir -Directory -Filter "azcopy*" | Rename-Item  -NewName 'azcopy' -Force
