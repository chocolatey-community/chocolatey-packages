$ErrorActionPreference = 'Stop';
 
$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext.azureedge.net/releases/release-10.26.0-20240731/azcopy_windows_amd64_10.26.0.zip'
    checksum64     = '48e493e213ad8a252e13ef3cc8018aaed47ccc28635a222fad108dfa37c7dc01'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext.azureedge.net/releases/release-10.26.0-20240731/azcopy_windows_386_10.26.0.zip'
    checksum       = '7b37f53575ebe8324d7bd6b8e9bfb56e3c84c7f0fddaab3b5c3de80843c35283'
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
