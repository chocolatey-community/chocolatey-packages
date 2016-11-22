$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'autohotkey.portable'
  url            = 'https://autohotkey.com/download/1.1/AutoHotkey_1.1.24.03.zip'
  url64Bit       = 'https://autohotkey.com/download/1.1/AutoHotkey_1.1.24.03.zip'
  checksum       = 'aede977e786a059e196b7b4f1fee73e57ce8755a34c9e8c092b69f83eca023ee'
  checksum64     = 'aede977e786a059e196b7b4f1fee73e57ce8755a34c9e8c092b69f83eca023ee'
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
    mv "$toolsPath/AutoHotkeyU64.exe" "$toolsPath/AutoHotkey.exe" -Force
} else {
    Write-Verbose "Removing x64 version"
    rm "$toolsPath/AutoHotkeyU64.exe" -ea 0
    mv "$toolsPath/AutoHotkeyU32.exe" "$toolsPath/AutoHotkey.exe" -Force
}
