$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.31.0/azcopy_windows_amd64_10.31.0.zip'
    checksum64     = '12b93fa3e75ed40fd9fa8417e93ff1358ffa74a272a63fc28c468523bc32ef48'
    checksumType64 = 'sha256'
    url            = 'https://github.com/Azure/azure-storage-azcopy/releases/download/v10.31.0/azcopy_windows_386_10.31.0.zip'
    checksum       = 'ea4aefd162ed644bae69af2e814ebe4603be1c370d7e300f856a9fb6d58dc182'
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
