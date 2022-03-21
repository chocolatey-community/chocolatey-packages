$process = Get-Process "Notepad++*" -ea 0

if ($process) {
  $runningFile = "$env:TEMP\npp.running"
  $processPath = $process | Where-Object { $_.Path } | Select-Object -First 1 -ExpandProperty Path
  Set-Content -Value "$processPath" -Path $runningFile

  Write-Host "Found Running instance of Notepad++. Stopping processes..."
  $process | Stop-Process
}
