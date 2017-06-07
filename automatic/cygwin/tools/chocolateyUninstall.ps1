$ErrorActionPreference = 'Stop'

$cygwin_root = (Get-ItemProperty 'HKLM:\SOFTWARE\Cygwin\setup' -ea 0).rootdir
rm 'HKLM:\SOFTWARE\Cygwin' -Recurse -ErrorAction SilentlyContinue
if (Test-Path "$cygwin_root\Cygwin.bat") {
    Write-Host 'Removing cygwin files'
    rm $cygwin_root -recurse -force -ea 0
}

Uninstall-BinFile -Name Cygwin
