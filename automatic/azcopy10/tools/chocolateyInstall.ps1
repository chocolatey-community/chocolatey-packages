$ErrorActionPreference = 'Stop';
 
$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext.azureedge.net/releases/release-10.27.0-20241030/azcopy_windows_amd64_10.27.0.zip'
    checksum64     = 'bddfeea5198434abe191e35d0d78f42a5c9d8863d33b0d87554bf7b48d4190e6'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext.azureedge.net/releases/release-10.27.0-20241030/azcopy_windows_386_10.27.0.zip'
    checksum       = '36ac53ab65c520e489207cc7a62094f26854ca74ce7309d36b9b8a759d5fe05d'
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
