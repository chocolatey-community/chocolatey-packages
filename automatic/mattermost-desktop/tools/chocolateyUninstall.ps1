$packageName = 'mattermost-desktop'
$softwareName = 'Mattermost*'
$installerType = 'exe'

$silentArgs = @("--uninstall", "-s")
$validExitCodes = @(0)

[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {

	# We need to remove the --uninstall argument from the uninstall string.
    $file = $key.UninstallString.Substring(0, $key.UninstallString.IndexOf(' '))

	Uninstall-ChocolateyPackage -PackageName $packageName `
								-FileType $installerType `
								-SilentArgs "$silentArgs" `
								-ValidExitCodes $validExitCodes `
								-File "$file"

} elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
    Write-Warning "$key.Count matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | ForEach-Object {Write-Warning "- $_.DisplayName"}
}
