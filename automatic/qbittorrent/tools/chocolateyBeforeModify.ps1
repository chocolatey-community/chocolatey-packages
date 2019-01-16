$processName = 'qBittorrent*'
$process = Get-Process -Name $processName

if ($process) {
  Write-Host "Stopping qBittorrent process..."
  Stop-Process -InputObject $process

  Start-Sleep -Seconds 3

  $process = Get-Process -Name $processName
  if ($process) {
    Write-Warning "Killing qBittorrent process..."
    Stop-Process -InputObject $process -Force
  }

  Write-Warning "qBittorrent will not be started after upgrading..."
}
