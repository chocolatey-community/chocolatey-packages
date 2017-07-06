$ErrorActionPreference = 'Stop'

[array]$key = Get-UninstallRegistryKey -SoftwareName 'ScreenCloud'

if($key.Count -eq 1){
    $key | % {
        $file = "$($_.UninstallString)"

        $packageArgs = @{
            packageName    = 'screencloud'
            fileType       = 'msi'
            silentArgs     = "$($_.PSChildName) /qn /norestart"
            validExitCodes = @(0)
            file           = ''
        }

        Uninstall-ChocolateyPackage @packageArgs
    }
} elseif ($key.Count -eq 0){
    Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1){
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | % {Write-Warning "- $($_.DisplayName)"}
}
