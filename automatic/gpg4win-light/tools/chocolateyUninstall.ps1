$ErrorActionPreference = 'Stop'

$packageName         = 'gpg4win-light'
$softwareNamePattern = 'Gpg4win *'

[array] $key = Get-UninstallRegistryKey $softwareNamePattern
if ($key.Count -eq 1) {
    $key | % {
        $packageArgs = @{
            packageName            = $packageName
            silentArgs             = "/S"
            fileType               = 'EXE'
            validExitCodes         = @(0)
            file                   = $_.UninstallString
        }
        Uninstall-ChocolateyPackage @packageArgs
    }
}
elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | % {Write-Warning "- $($_.DisplayName)"}
}

