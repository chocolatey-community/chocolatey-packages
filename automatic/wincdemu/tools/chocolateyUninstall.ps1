$ErrorActionPreference = 'Stop'

$packageName = 'wincdemu'

$packageArgs = @{
    packageName            = $packageName
    silentArgs             = "/UNATTENDED"
    fileType               = 'EXE'
    validExitCodes         = @(0)
    file                   = ''
}

[array] $key = Get-UninstallRegistryKey $packageName
if ($key.Count -eq 1) {
    $key | % {
        $packageArgs.file = $_.UninstallString
        Uninstall-ChocolateyPackage @packageArgs
        sleep 2
        ps wcduninst -ea 0 | kill   #Kill the message 'WincdEMU was uninstalled | OK'
    }
}
elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
    Write-Warning "$key.Count matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | % {Write-Warning "- $_.DisplayName"}
}

