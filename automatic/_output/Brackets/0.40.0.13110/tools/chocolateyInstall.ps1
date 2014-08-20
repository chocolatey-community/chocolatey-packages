$packageName = 'Brackets'
$version = '0.40.0.13109'

try {

    $bracketsRegistryVersion = $version -replace '^(\d+\.\d+)\..+', '$1'

    $params = @{
        PackageName = $packageName;
        FileType = 'msi';
        SilentArgs = '/q';
        Url = 'https://github.com/adobe/brackets/releases/download/sprint-40/Brackets.Sprint.40.msi';
    }

    $alreadyInstalled = Get-WmiObject -Class Win32_Product |
        Where-Object {($_.Name -eq 'Brackets') -and
        ($_.Version -match $bracketsRegistryVersion)}

    if ($alreadyInstalled) {
        Write-Host "Brackets $version is already installed. Skipping installation."
    } else {
        Install-ChocolateyPackage @params
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
