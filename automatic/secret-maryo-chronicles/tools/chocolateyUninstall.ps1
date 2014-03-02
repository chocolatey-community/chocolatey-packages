try {

    $packageName = '{{PackageName}}'
    $fileType = "exe"
    $silentArgs = "/S"
    $validExitCodes = @(0)
    
    $unfile = "${Env:ProgramFiles}\Secret Maryo Chronicles\uninstall.exe"
    $unfilex86 = "${Env:ProgramFiles(x86)}\Secret Maryo Chronicles\uninstall.exe"
    
    if (Test-Path "$unfile") {$file = "$unfile"}
    if (Test-Path "$unfilex86") {$file = "$unfilex86"}
    
    if ((Test-Path "$unfile") -or (Test-Path "$unfilex86")) {
        Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
    }

    $packageName = 'secret-maryo-chronicles-addon-music'
    $unfile = "${Env:ProgramFiles}\Secret Maryo Chronicles\uninstall_music.exe"
    $unfilex86 = "${Env:ProgramFiles(x86)}\Secret Maryo Chronicles\uninstall_music.exe"
    
    if (Test-Path "$unfile") {$file = "$unfile"}
    if (Test-Path "$unfilex86") {$file = "$unfilex86"}
    
    if ((Test-Path "$unfile") -or (Test-Path "$unfilex86")) {
        Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file -validExitCodes $validExitCodes
    }
    
    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}