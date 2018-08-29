$downloadDir = Get-PackageCacheLocation
$installer          = 'SpotifyFullSetup.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'Spotify'
    file            = Join-Path $downloadDir $installer
    url             = 'https://download.spotify.com/SpotifyFullSetup.exe'
    checksum        = '80FE3F0B5ED6C2BDBFC91397EF852E3E4839E8361857E9AC1FE559CD52AD0E77895D69673A43CA912625DF851E3A1A945DDEBC7A6A49A2E4888404E1B0BD1734'
    fileType        = 'exe'
    checksumType    = 'sha512'
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
