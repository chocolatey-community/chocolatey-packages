$downloadDir = Get-PackageCacheLocation
$installer          = 'SpotifyFullSetup.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'Spotify'
    file            = Join-Path $downloadDir $installer
    url             = 'https://download.scdn.co/SpotifySetup.exe'
    checksum        = 'F31E945D29C7FED51C60EE472CDBADD20CCE140CEA12A03F45BB7E8D83F62138FF890A3DA4D43762D8D764E4A08B0F68DF1ABC681F73DFE290E8CD6AC353863B'
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
