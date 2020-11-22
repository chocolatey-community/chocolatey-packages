function Ensure-NotRunning() {
    Write-Host "Waiting max 60 seconds for the application to start..."
    for ($i=0; $i -lt 60; $i++) {
        Start-Sleep 1
        $process = Get-Process "main" -ea 0 | Where-Object { $_.MainWindowTitle -ilike 'EaseUS Partition Master*' }
        if ($process) { Start-Sleep 2; Write-Host "Application started"; break }
    }
    if (!$process) { Write-Warning "Timed out waiting for application"; return }

    Stop-Process $process -Force -ea 0
}
