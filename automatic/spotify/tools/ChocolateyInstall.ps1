$downloadDir = Get-PackageCacheLocation
$installer          = 'SpotifyFullSetup.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'Spotify'
    file            = Join-Path $downloadDir $installer
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = 'C1B024EB1EE9C4F1CAE2B02AE3CD7DCCDEDD1647342C33CD3130A1E5FCE768FB'
    fileType        = 'exe'
    checksumType    = 'sha256'
    silentArgs      = '/silent'
    validExitCodes  = @(0, 1641, 3010)
}

# Download the installer
$arguments['file'] = Get-ChocolateyWebFile @arguments

# It doesn't matter what time we choose, we need to start it manually
schtasks.exe /Create /SC Once /st (Get-Date -Format 'HH:mm') /TN $arguments['packageName'] /TR "'$($arguments['file'])' $($arguments['silentArgs'])" /F 2>$null
schtasks.exe /Run /TN $arguments['packageName']
Start-Sleep -s 1
schtasks.exe /Delete /TN $arguments['packageName'] /F

# Wait for Spotify to start, then kill it
$done = $false
do {
  if (Get-Process Spotify -ErrorAction SilentlyContinue) {
    Stop-Process -name Spotify
    $done = $true
  }

  Start-Sleep -s 10
} until ($done)
