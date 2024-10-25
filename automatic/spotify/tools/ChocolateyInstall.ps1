$downloadDir = Get-PackageCacheLocation
$installer          = 'SpotifyFullSetup.exe'
$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = 'Spotify'
    file            = Join-Path $downloadDir $installer
    url             = 'https://download.scdn.co/SpotifySetup.exe'
    checksum        = '541AF6F3DB8C662B81A94518B4371B19441249608D35E92C45B36B3A207969D1BD5FE0CFD7E5271C946B337E2CE1737ADD082804B5A59DC91AC99B4C2DF0DDC5'
    fileType        = 'exe'
    checksumType    = 'sha512'
    silentArgs      = '/silent'
    validExitCodes  = @(0, 1641, 3010)
}

# check we can use Get-AppxPackage
if (Get-Command 'Get-AppxPackage' -ErrorAction SilentlyContinue) {
    # there is likely going to be two packages returned for x86 and x64.
    # we don't care about the architecture, just the version and they will both be the same.
    $allAppxPackages = Get-AppxPackage
    $installedAppXPackage = @($allAppxPackages | Where-Object -Property Name -eq 'SpotifyAB.SpotifyMusic')
    if ($installedAppXPackage.Count -gt 0) {
        if ($env:ChocolateyForce) {
            #when you remove a package, you don't remove it per architecture. You just remove it for all architectures.
            Write-Warning 'Attempting to remove Spotify installed from the Microsoft Store.'
            Remove-AppxPackage -Package $installedAppXPackage[0].PackageFullName
        }
        else {
            throw "Cannot install the Spotify package because the Microsft Store version is installed. Please uninstall this manually or add the '--force' option to the command line."
        }
    }
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
