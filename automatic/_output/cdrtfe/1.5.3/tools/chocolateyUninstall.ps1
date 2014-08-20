try {

    $packageName = 'cdrtfe'
    $fileType = 'exe'
    $silentArgs = '/VERYSILENT'
    $validExitCodes = @(0)
    
    $unfile = 'C:\cdrtfe\uninst\unins000.exe'
    
    if (Test-Path $unfile) {
        Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $unfile -validExitCodes $validExitCodes
    }
    
    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}