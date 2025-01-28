$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.28.0-20250127/azcopy_windows_amd64_10.28.0.zip'
    checksum64     = 'd96194a60b3679e4a60d3c970ee9ee50b457170c6717ff7827c060d0371ffef5'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.28.0-20250127/azcopy_windows_386_10.28.0.zip'
    checksum       = '24b9544bf6c53a5e0566ca47235a13a5a4e3c148c29e764d599da5960097b7d1'
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
