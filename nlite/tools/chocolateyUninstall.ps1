try {

    $packageName = '{{PackageName}}'
    $fileType = "exe"
    $silentArgs = "/VERYSILENT"
    $validExitCodes = @(0)

    $binRoot = "$env:systemdrive\tools"
    if($env:chocolatey_bin_root -ne $null){$binRoot = join-path $env:systemdrive $env:chocolatey_bin_root}
    
    $file = "$binRoot\nLite\unins000.exe"
    
    if (Test-Path "$file") {
        Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
    }
    
    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}