$ErrorActionPreference = 'Stop'

$cygwin_root = (Get-ItemProperty 'HKLM:\SOFTWARE\Cygwin\setup' -ea 0).rootdir
Remove-Item 'HKLM:\SOFTWARE\Cygwin' -Recurse -ErrorAction SilentlyContinue
if (Test-Path "$cygwin_root\Cygwin.bat") {
    Write-Host 'Removing cygwin files'
    Remove-Item $cygwin_root -recurse -force -ea 0
}

Uninstall-BinFile -Name Cygwin
