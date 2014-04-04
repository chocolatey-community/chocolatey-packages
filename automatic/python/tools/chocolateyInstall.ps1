$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'
$version = '{{PackageVersion}}'
$fileType = 'msi'
$silentArgs = '/passive'

try {

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

    $pythonFolder = 'Python' + $version -replace '(\d)\.(\d)\.\d+', '$1$2'

    $pythonPath = Join-Path $env:systemdrive "$pythonFolder\"

    if (Test-Path $pythonPath) {
        Install-ChocolateyPath $pythonPath 'Machine'
    } else {
        Write-Host "Folder for Python path couldn’t be determined. Please add it manually to your Path environment variable"
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
}
