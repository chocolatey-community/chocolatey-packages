$packageName = 'tightvnc'
$fileType = 'msi'
$silentArgs = '/quiet /norestart'
$url = 'http://www.tightvnc.com/download/2.7.10/tightvnc-2.7.10-setup-32bit.msi'
$url64bit = 'http://www.tightvnc.com/download/2.7.10/tightvnc-2.7.10-setup-64bit.msi'

try {

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit


    # This reads the service start mode of 'TightVNC Server' and adapts it to the current value,
    # otherwise it would always be set to 'Auto' on new installations, even if it was 'Manual'
    # or 'disabled' before
    $serviceStartMode = (Get-wmiobject win32_service -Filter "Name = 'tvnserver'").StartMode

    if ($serviceStartMode -ne $null) {
        if ($serviceStartMode -ne 'Auto') {
            Start-ChocolateyProcessAsAdmin "Set-Service -Name tvnserver -StartupType $serviceStartMode"
        }
    }

} catch {

    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}