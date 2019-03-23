$ErrorActionPreference = 'Stop'

$softwareNamePattern = 'WinPcap*'

[array] $key = Get-UninstallRegistryKey $softwareNamePattern
if ($key.Count -eq 1) {
    $key | ForEach-Object {
        Write-Output "Running Autohotkey uninstaller"
        $toolsPath = Split-Path $MyInvocation.MyCommand.Definition
        $ahkScript = "$toolsPath\winpcapInstall.ahk"
        AutoHotkey $ahkScript uninstall $_.UninstallString
    }
}
elseif ($key.Count -eq 0) {
    Write-Warning "$env:ChocolateyPackageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}
