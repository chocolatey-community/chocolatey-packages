$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.30.1/azcopy_windows_amd64_10.30.1.zip'
    checksum64     = 'df85f0f43cd71a2634eb7c49fc404ffccb958dffe778ad9804ddfca2d48565b6'
    checksumType64 = 'sha256'
    url            = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.30.1/azcopy_windows_386_10.30.1.zip'
    checksum       = 'd9b91a796c1c5fb6194865ee3a30c3143f74d1f9eb1e81518bf6840f4d3deb61'
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
