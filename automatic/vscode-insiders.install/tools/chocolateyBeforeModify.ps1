Get-Process "Code - Insiders" -ea 0 | ForEach-Object { $_.CloseMainWindow() | Out-Null }
Start-Sleep 1
Get-Process "Code - Insiders" -ea 0 | Stop-Process  #in case gracefull shutdown did not succeed, try hard kill
