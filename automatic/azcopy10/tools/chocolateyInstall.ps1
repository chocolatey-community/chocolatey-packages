$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.29.1-20250515/azcopy_windows_amd64_10.29.1.zip'
    checksum64     = 'f5dc02e2b2cdcd8dbee719abb60499ea1409526d89b0d5c23cfa62c5621e5b0c'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.29.1-20250515/azcopy_windows_386_10.29.1.zip'
    checksum       = '130e5044bdc14747b13f6ab5aae8bbd6157ab03fe855d95556f3643c98b4eecf'
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
