$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.29.0-20250428/azcopy_windows_amd64_10.29.0.zip'
    checksum64     = 'eb6e9cfe79aa95d8cbdcef64501d36dec951848cf7591eb404fd8c154aa6e7c0'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.29.0-20250428/azcopy_windows_386_10.29.0.zip'
    checksum       = 'a28ccabab154b227eed4af953b3a93168d7458beaa34ee30ea0a8ab4f6e17483'
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
