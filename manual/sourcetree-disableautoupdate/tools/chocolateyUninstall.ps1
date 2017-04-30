$ErrorActionPreference = 'Stop'

# Enable auto update
Remove-ItemProperty -Name 'AutoUpdatePolicy' -Path 'HKCU:\Software\Caphyon\Advanced Updater\{138B87CA-4905-43FE-BB63-184FFB0CE1EC}\Settings'
