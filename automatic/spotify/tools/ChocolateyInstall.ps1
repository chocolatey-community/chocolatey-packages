$downloadDir = Get-PackageCacheLocation
$installer          = 'SpotifyFullSetup.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'Spotify'
    file            = Join-Path $downloadDir $installer
    url             = 'https://download.scdn.co/SpotifySetup.exe'
    checksum        = '0B13D3AAB5895D3ED5E46992BB30F6B881C050909DB0D73F55739ADFB5187D733B0AAAE4720E901E635BF8C09B1728D5F0A8507C6E370E030D42A0124500607F'
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
