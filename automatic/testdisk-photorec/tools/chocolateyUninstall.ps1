$ErrorActionPreference = 'Stop'

$files = @('testdisk_win.lnk', '*photorec_win.lnk')
$desktopPath = [System.Environment]::GetFolderPath('Desktop')

$files | ? { Test-Path "$desktopPath\$_" } | % { Remove-Item -Force "$desktopPath\$_" }
