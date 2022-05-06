function StopProcesses() {
  $processNames = @("genpass", "gensfc", "kageant", "cygtermd", "kitty", "kittygen", "klink", "kscp", "ksftp")
  $processes = Get-Process  $processNames -ea SilentlyContinue

  if ($processes) {
    $activeProcesses = ($processes | Select-Object -ExpandProperty name | Sort-Object -Unique) -join ","
    Write-Warning "Stopping processes: $activeProcesses to prevent upgrade/uninstall failure..."
    Stop-Process -InputObject $processes

    Start-Sleep -Seconds 3

    $processes = Get-Process  $processNames -ea SilentlyContinue
    if ($processes) {
      $activeProcesses = ($processes | Select-Object -ExpandProperty name | Sort-Object -Unique) -join ","
      Write-Warning "Killing processes: $activeProcesses to prevent upgrade/uninstall failure..."
      Stop-Process -InputObject $processes -Force
    }
  }
}

