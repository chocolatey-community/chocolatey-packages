$packageName = 'Brackets'

try {

    $app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -eq 'Brackets'}
    if ($app) {
        $msiArgs = $('/x' + $app.IdentifyingNumber + ' /q REBOOT=ReallySuppress')
        Start-ChocolateyProcessAsAdmin $msiArgs 'msiexec'
    }

    Write-ChocolateySuccess $packageName

    
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
