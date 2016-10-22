$ErrorActionPreference = 'Stop'

$url32       = 'https://autohotkey.com/download/1.1/AutoHotkey_1.1.24.02.zip'
$url64       = $url32
$checksum32  = '7f905a3d1cc5de0a8f599b0e090ada871b5af21147814bfcdce59eac8f58dd51'
$checksum64  = $checksum32
$toolsPath   = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'autohotkey.portable'
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "Removing ANSI version"
rm "$toolsPath/AutoHotkeyA32.exe" -ea 0
if (Get-ProcessorBits 64) {
    Write-Verbose "Removing x32 version"
    rm "$toolsPath/AutoHotkeyU32.exe" -ea 0
    mv "$toolsPath/AutoHotkeyU64.exe" "$toolsPath/AutoHotkey.exe"
} else {
    Write-Verbose "Removing x64 version"
    rm "$toolsPath/AutoHotkeyU64.exe" -ea 0
    mv "$toolsPath/AutoHotkeyU32.exe" "$toolsPath/AutoHotkey.exe"
}
