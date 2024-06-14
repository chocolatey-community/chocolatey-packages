$ErrorActionPreference = 'Stop';
 
$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext.azureedge.net/releases/release-10.25.1-20240612/azcopy_windows_amd64_10.25.1.zip'
    checksum64     = 'c31b31cc1a48458ddb409ed6842ec03858083b26d877e226bf3d528512392bd3'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext.azureedge.net/releases/release-10.25.1-20240612/azcopy_windows_386_10.25.1.zip'
    checksum       = 'c97a6fb2bc0d2a8dadfd23db0c684338f2736f9f48633af89b95d7cc98111ea8'
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
