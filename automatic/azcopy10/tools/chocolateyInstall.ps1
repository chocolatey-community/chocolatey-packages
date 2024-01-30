$ErrorActionPreference = 'Stop';
 
$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext.azureedge.net/releases/release-10.23.0-20240129/azcopy_windows_amd64_10.23.0.zip'
    checksum64     = '10eac5da6b883cb555f8e2469a8fd3d14116eb818d0da3d8e3b3124c69d6d568'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext.azureedge.net/releases/release-10.23.0-20240129/azcopy_windows_386_10.23.0.zip'
    checksum       = '55a637d171db6f6d3c22c96f37c5e4a852a05a3535ef572996a938253bbeced7'
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
