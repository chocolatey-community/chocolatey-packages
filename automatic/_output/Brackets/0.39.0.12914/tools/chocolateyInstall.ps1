$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$isAlreadyInstalled = Join-Path $scriptDir 'isAlreadyInstalled.ps1'

Import-Module $isAlreadyInstalled

$packageName = 'Brackets'
$version = '0.39.0.12914'
$bracketsRegistryVersion = $version -replace '(\d\.\d+)\..+', '$1'

try {
    $params = @{
        PackageName = $packageName;
        FileType = 'msi';
        SilentArgs = '/q';
        Url = 'https://github.com/adobe/brackets/releases/download/sprint-39/Brackets.Sprint.39.msi';
    }

    $alreadyInstalled = isAlreadyInstalled 'Brackets' $bracketsRegistryVersion

    if (-not($alreadyInstalled)) {
        Install-ChocolateyPackage @params
    } else {
        Write-Output "Brackets $version is already installed. Skipping installation."
    }

    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw
}
