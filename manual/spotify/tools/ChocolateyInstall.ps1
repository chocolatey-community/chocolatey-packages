$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'Spotify'
  fileType        = 'exe'
  file            = Join-Path (Split-Path -Parent $script) 'SpotifyFullSetup.exe'
  url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
  softwareName    = 'Spotify*'
  checksum        = 'E69C3B92A6FBFEB8A43C5D66512DEB9F47EFADD57490E51658C4F066864FDE37'
  checksumType    = 'sha256'
  silentArgs      = '/silent'
  validExitCodes  = @(0, 3010, 1641)
}

# Download the installer
$arguments['file'] = Get-ChocolateyWebFile @arguments

# Use a scheduled task to get around the requirment to install as a regular user
$action = New-ScheduledTaskAction -Execute $arguments['file'] -Argument $arguments['silentArgs']
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date)
Register-ScheduledTask -TaskName $arguments['packageName'] -Action $action -Trigger $trigger
Start-ScheduledTask -TaskName $arguments['packageName']
Start-Sleep -s 1
Unregister-ScheduledTask -TaskName $arguments['packageName'] -Confirm:$false

# Wait for Spotify to start, then kill it
$done = $false
do {
  if (Get-Process Spotify -ErrorAction SilentlyContinue) {
    Stop-Process -name Spotify
    $done = $true
  }

  Start-Sleep -s 10
} until ($done)