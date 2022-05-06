function StopProcesses() {
  $processNames = @("genpass", "gensfc", "kageant", "cygtermd", "kitty", "kittygen", "klink", "kscp", "ksftp")
  $processes = Get-Process  $processNames -ea SilentlyContinue

  if ($processes) {
    Write-Warning "Stopping processes to prevent upgrade/uninstall failure..."
    Stop-Process -InputObject $processes -Force
  }
}
