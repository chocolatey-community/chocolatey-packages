$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.31.1/azcopy_windows_amd64_10.31.1.zip'
    checksum64     = 'bb71e8e3d2834c803f2a91ee0827d023e933b74554793debdc60cd3b11b74b87'
    checksumType64 = 'sha256'
    url            = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.31.1/azcopy_windows_386_10.31.1.zip'
    checksum       = 'd45bd7c18bd11e33124e3047c788bc915cba7547efe8b40361a280629c01e547'
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
