function stopProcessIfExist([switch]$sleepAfter) {
  function getProcess() {
    return Get-Process "main" -ea 0 | Where-Object { $_.MainWindowTitle -ilike 'EaseUS Partition Master*' }
  }

  $process = getProcess

  if ($process) {
    Write-Host "Trying to gently close the application..."
    $process.CloseMainWindow()

    Start-Sleep -Seconds 5 # The program seem to take a little while to close
    # We'll check again to make sure the process is closed
    $process = getProcess
    if ($process) {
      Write-Host "Forcing the application to close..."
      Stop-Process -InputObject $process -Force
    }

    if ($sleepAfter) {
      Write-Host "Sleeping to make sure the application is closed, otherwise upgrade/uninstall will fail..."
      Start-Sleep -Seconds 10
    }
  }
}
