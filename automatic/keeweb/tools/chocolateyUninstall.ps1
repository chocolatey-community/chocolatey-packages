$packageName = 'keeweb'
$softwareName = 'keeweb*'
$installerType = 'exe'

$silentArgs = '/S'
# It seems weird, but actually the uninstaller always returns 2 as exit code.
#  Uninstalling keeweb...
#  WARNING: Setup was cancelled.
#  WARNING: Exit code '2' was considered valid by script, but not as a Chocolatey success code. Returning '0'.
#  0
#  keeweb has been uninstalled.
# We cannot rely on choco autouninstaller feature, otherwise the uninstall
# process will be considered as a failure (and tests performed by Chocolatey will fail).
$validExitCodes = @(2)

[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
    $key | ForEach-Object {
        # The chocolatey uninstaller function when used in combination of a
        # registry key has issues with some NSIS and InnoSetup installers.
        # Even if the following bug has been fixed, we still need to
        # circumvent this issue.
        # https://github.com/chocolatey/choco/issues/1039
        $file = "$($_.UninstallString.Trim('"'))"
    
        Uninstall-ChocolateyPackage -PackageName $packageName `
                                    -FileType $installerType `
                                    -SilentArgs "$silentArgs" `
                                    -ValidExitCodes $validExitCodes `
                                    -File "$file"
    }
} elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
    Write-Warning "$key.Count matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | ForEach-Object {Write-Warning "- $_.DisplayName"}
}
