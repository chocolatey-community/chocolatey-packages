$ErrorActionPreference = 'Stop'

$fileName  = 'AutoHotkey_1.1.27.00.zip'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$zip_path = "$toolsPath\$fileName"
rm $toolsPath\* -Recurse -Force -Exclude $fileName

$packageArgs = @{
    PackageName  = 'autohotkey.portable'
    FileFullPath = $zip_path
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $zip_path -ea 0

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
