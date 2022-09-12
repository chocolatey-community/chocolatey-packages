$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

StopProcesses

$packageArgs = @{
    PackageName    = 'kitty'
    FileFullPath   = "$toolsPath\kitty-bin-0.76.0.11.zip"
    Destination    = $toolsPath
  }

Get-ChocolateyUnzip @packageArgs
# Remove kitty.exe to replace with either kitty_nocompress.exe or kitty_portable.exe
Remove-Item -force "$toolsPath\*.zip", "$toolsPath\kitty-beta.exe", "$toolsPath\kitty.exe" -ea 0

$pp = Get-PackageParameters
if ($pp.Portable) {
    # Replace kitty.exe with kitty_portable.exe
    Rename-Item "$toolsPath\kitty_portable.exe" "$toolsPath\kitty.exe"
    Remove-Item -force "$toolsPath\kitty_nocompress.exe" -ea 0

    Write-Host 'Setting portable mode'
    $iniPath = Join-Path $toolsPath 'kitty.ini'
    if (Test-Path $iniPath) { $ini = Get-Content $iniPath -Encoding ascii -ea 0 | Out-String }

    # kitty ini file doesn't seem to have any other option now
    if ($ini -notmatch 'savemode=dir') { "[KiTTY]`nsavemode=dir" | Out-File -Encoding ascii $iniPath }
} else {
    # Replace kitty.exe with kitty_nocompress.exe to avoid AV false positives
    Rename-Item "$toolsPath\kitty_nocompress.exe" "$toolsPath\kitty.exe"
    Remove-Item -force "$toolsPath\kitty_portable.exe" -ea 0
}
