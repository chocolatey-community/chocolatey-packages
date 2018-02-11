$ErrorActionPreference = 'Stop'

$fileName  = 'AutoHotkey_1.1.28.00.zip'
$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$zip_path = "$toolsPath\$fileName"
Remove-Item $toolsPath\* -Recurse -Force -Exclude $fileName

$packageArgs = @{
    PackageName  = 'autohotkey.portable'
    FileFullPath = $zip_path
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
Remove-Item $zip_path -ea 0

Write-Host "Removing ANSI version"
Remove-Item "$toolsPath/AutoHotkeyA32.exe" -ea 0
if (Get-OSArchitectureWidth 64) {
    Write-Verbose "Removing x32 version"
    Remove-Item "$toolsPath/AutoHotkeyU32.exe" -ea 0
    Move-Item "$toolsPath/AutoHotkeyU64.exe" "$toolsPath/AutoHotkey.exe" -Force
} else {
    Write-Verbose "Removing x64 version"
    Remove-Item "$toolsPath/AutoHotkeyU64.exe" -ea 0
    Move-Item "$toolsPath/AutoHotkeyU32.exe" "$toolsPath/AutoHotkey.exe" -Force
}
