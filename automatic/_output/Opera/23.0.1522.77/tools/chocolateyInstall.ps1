$packageName = 'Opera'
$version = '23.0.1522.77'
$fileType = 'exe'
$installArgs = '/install /silent /launchopera 0 /setdefaultbrowser 0'
$url = 'http://get.geo.opera.com/pub/opera/desktop/23.0.1522.77/win/Opera_23.0.1522.77_Setup.exe'

try {

    $regPathModifierArray = @('Wow6432Node\', '')
    $alreadyInstalled = $null

    foreach ($regPathModifier in $regPathModifierArray) {
        $regPath = "HKLM:\SOFTWARE\${regPathModifier}Microsoft\Windows\CurrentVersion\Uninstall\Opera $version"
        if (Test-Path $regPath) {
            $alreadyInstalled = $true
        }
    }

    if ($alreadyInstalled) {
        Write-Output "Opera $version is already installed. Skipping download and installation."
    } else {
        Install-ChocolateyPackage $packageName $fileType $installArgs $url
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
