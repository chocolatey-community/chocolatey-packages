$processName = 'gpg-agent*'
$process = Get-Process -Name $processName

if ($process) {
  Write-Warning "Stopping GPG Agent to prevent git upgrade/uninstall failure..."
  Stop-Process -InputObject $process

  Start-Sleep -Seconds 3

  $process = Get-Process -Name $processName
  if ($process) {
    Write-Warning "Killing GPG Agent to prevent git upgrade/uninstall failure..."
    Stop-Process -InputObject $process -Force
  }

  Write-Warning "GPG Agent will not be started by the package after upgradeing..."
}
