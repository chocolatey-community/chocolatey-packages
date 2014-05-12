$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'
$version = '{{PackageVersion}}'
$fileType = 'msi'
$silentArgs = '/passive'

try {

    $alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match "Python $version"}

    if ($alreadyInstalled) {
        Write-Output "Python $version is already installed. Skipping download and installation."   
    } else {
    
        Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

        $pythonFolder = 'Python' + $version -replace '(\d)\.(\d+)\.\d+', '$1$2'

        $pythonPath = Join-Path $env:systemdrive "$pythonFolder\"

        if (Test-Path $pythonPath) {
            Install-ChocolateyPath $pythonPath 'Machine'
        } else {
            Write-Output "Folder for Python path couldn’t be determined. Please add it manually to your Path environment variable"
        }
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
}
