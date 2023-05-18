$ErrorActionPreference = 'Stop'

$packageName         = $Env:ChocolateyPackageName
$softwareNamePattern = 'startallback*'
$installLocation = Get-AppInstallLocation $softwareNamePattern

[array] $key = Get-UninstallRegistryKey $softwareNamePattern
if ($key.Count -eq 1) {

    $key | ForEach-Object {
        $packageArgs = @{
            packageName            = $packageName
            silentArgs             = "/uninstall /silent"
            fileType               = 'exe'
            validExitCodes         = @(0)
            file                   = "$($_.UninstallString.Replace(' /uninstall', ''))"
        }
        Uninstall-ChocolateyPackage @packageArgs
    }

    if (Test-Path $installLocation) {
        Wait-Process -Name $softwareNamePattern -Timeout 10 -ErrorAction SilentlyContinue
        Remove-Item $installLocation -Recurse -Force
    }
}
elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}

