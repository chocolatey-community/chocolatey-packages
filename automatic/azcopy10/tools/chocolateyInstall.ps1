$ErrorActionPreference = 'Stop';

$packageName = 'azcopy10'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $packageName
    url64          = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.27.1-20241113/azcopy_windows_amd64_10.27.1.zip'
    checksum64     = 'd0cfe7c3682b960f1ff70f4f763f8ac89a13bed91866ee4cea1150daf2cd8aa0'
    checksumType64 = 'sha256'
    url            = 'https://azcopyvnext-awgzd8g7aagqhzhe.b02.azurefd.net/releases/release-10.27.1-20241113/azcopy_windows_386_10.27.1.zip'
    checksum       = '14a339020b56c6dbb994f3b9a496b5a5abdbd7011e1aa705ba507e20711dd530'
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
