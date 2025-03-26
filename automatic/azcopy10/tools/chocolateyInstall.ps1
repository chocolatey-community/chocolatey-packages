$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.28.1-20250326/azcopy_windows_amd64_10.28.1.zip'
    checksum64     = 'afbb11b1c86f3b32b3c62a44267e45dce8420d2c8204e175b64041516d2c072f'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.28.1-20250326/azcopy_windows_386_10.28.1.zip'
    checksum       = '20227e1f80611eb3891e4ef4b34e6a113f51bb0469d71fdcf6904f387a0fb9c2'
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
