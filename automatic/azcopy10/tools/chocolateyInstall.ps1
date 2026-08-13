$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.32.7/azcopy_windows_amd64_10.32.7.zip'
    checksum64     = '7a7e572ea75445acf856cba53e8985374e46ecd3db6324042fc1911c5e27e30a'
    checksumType64 = 'sha256'
    url            = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.32.7/azcopy_windows_386_10.32.7.zip'
    checksum       = '447300b59f49e9ac211f23b2580dcb839a698c08f421be21a2ebd12f939d157a'
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
