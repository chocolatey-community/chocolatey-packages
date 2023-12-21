$ErrorActionPreference = 'Stop';
 
$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext.azureedge.net/releases/release-10.22.1-20231220/azcopy_windows_amd64_10.22.1.zip'
    checksum64     = '5c48d622f300e6d76b5218253668b77181d1897968fc39ec7bbc766c49da065e'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext.azureedge.net/releases/release-10.22.1-20231220/azcopy_windows_386_10.22.1.zip'
    checksum       = '4e08bebb46c870cab44a97514f8902ebe482a87491bb89dc567143b475c9c366'
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
