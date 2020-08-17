function Close-VSCodeInsiders {
  $processName = 'Code - Insiders'
  if (Get-Process $processName -ErrorAction SilentlyContinue) {
    Write-Host "Closing $processName"
    Get-Process $processName -ErrorAction SilentlyContinue | ForEach-Object { $_.CloseMainWindow() | Out-Null }
    Start-Sleep 1
    Get-Process $processName -ErrorAction SilentlyContinue | Stop-Process  #in case gracefull shutdown did not succeed, try hard kill
  }
}
