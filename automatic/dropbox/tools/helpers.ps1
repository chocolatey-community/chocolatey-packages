function getDropboxRegProps() {
    $uninstallRegistryPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Dropbox'

    if (Test-Path $uninstallRegistryPath) {
        $props = @{
            "DisplayVersion" = (Get-ItemProperty $uninstallRegistryPath).DisplayVersion
            "UninstallString" = (Get-ItemProperty $uninstallRegistryPath).UninstallString
        }
    }

    return $props
 }
