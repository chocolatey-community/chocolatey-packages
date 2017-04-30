$ErrorActionPreference = 'Stop'

# Disable auto update
New-Item 'HKCU:\Software\Caphyon\Advanced Updater\{138B87CA-4905-43FE-BB63-184FFB0CE1EC}\Settings' -Force | New-ItemProperty -Name AutoUpdatePolicy -Value 0 -Force
