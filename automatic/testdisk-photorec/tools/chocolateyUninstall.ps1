$ErrorActionPreference = 'Stop'

$files = @('testdisk_win.lnk', '*photorec_win.lnk')
$desktopPath = [System.Environment]::GetFolderPath('Desktop')

$files | Where-Object { Test-Path "$desktopPath\$_" } | ForEach-Object { Remove-Item -Force "$desktopPath\$_" }
