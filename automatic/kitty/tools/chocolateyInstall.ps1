$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if ($pp.Portable) {
    Write-Host 'Setting portable mode'
    
    $iniPath = Join-Path $toolsPath 'kitty.ini'
    if (Test-Path $iniPath) { $ini = gc $iniPath -Encoding ascii -ea 0 | Out-String }    
    # kitty ini file doesn't seem to have any other option now
    if ($ini -notmatch 'savemode=dir') { "[KiTTY]`nsavemode=dir" | Out-File -Encoding ascii $iniPath }
}
