$packageName = 'python3'
$url = 'http://www.python.org/ftp/python/3.3.5/python-3.3.5.msi'
$url64bit = 'http://www.python.org/ftp/python/3.3.5/python-3.3.5.amd64.msi'
$version = '3.3.5'
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
