$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-Process "main" -ea 0 | Where-Object { $_.MainWindowTitle -ilike 'EaseUS Partition Master*' } | Stop-Process
