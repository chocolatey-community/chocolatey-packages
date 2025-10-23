$ErrorActionPreference = 'Stop';

Write-Host 'Removing shortcuts...'

$startMenu = [System.Environment]::GetFolderPath("CommonStartMenu")
$shortcut = 'Remote Desktop Connection Manager.lnk'
$shortcutx86 = 'Remote Desktop Connection Manager x86.lnk'

Remove-Item -Path $(Join-Path $startMenu "Programs/$shortcut") -Force -ErrorAction Ignore
Remove-Item -Path $(Join-Path $startMenu "Programs/$shortcutx86") -Force -ErrorAction Ignore
