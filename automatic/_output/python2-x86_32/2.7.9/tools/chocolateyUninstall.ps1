# This file should be identical for all python* packages

$packageName = 'python2-x86_32'
$is64Bit = $null

try {

    # Generate the match object to determine which python* package it is,
    # e.g, a package for a specific major Python version or a forced 32-bit package.
    $matchObj = [Regex]::Match($packageName, '^python(\d)?([\-_]x86[\-_]32)?')
    $osBitness = Get-ProcessorBits

    # If the python package is not forced 32-bit and the system is 64-bit,
    # add "(64-bit)" to the appName regex
    if (!$matchObj.Groups[2].Value -and ($osBitness -eq 64)) {
        $is64Bit = '\(64-bit\)'
    }

    # Construct the appName regex and check if the matched Python is installed
    $appRegex = $('^Python ' + $matchObj.Groups[1] + '[\d\.]+\s?' + $is64Bit + '$')
    $app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match $appRegex}

    # If the matched Python is installed, uninstall it, else give a message
    if ($app) {
        $msiArgs = $('/x' + $app.IdentifyingNumber + ' /q REBOOT=ReallySuppress')
        Write-Host "Uninstalling $packageName from system using msiexec …"
        Start-ChocolateyProcessAsAdmin $msiArgs 'msiexec'
        Write-ChocolateySuccess $packageName
    } else {
        Write-Host "$packageName is not installed on the system. Nothing to do."
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
