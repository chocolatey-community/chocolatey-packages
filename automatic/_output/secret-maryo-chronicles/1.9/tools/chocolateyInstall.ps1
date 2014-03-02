try {
    $packageName = 'secret-maryo-chronicles'
    $fileType = 'exe'
    $silentArgs = '/S'
    $url = 'http://netcologne.dl.sourceforge.net/project/smclone/Secret Maryo Chronicles/1.9/SMC_1.9_win32.exe'

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

    $packageName = "secret-maryo-chronicles-addon-music"
    $url = "http://sourceforge.net/projects/smclone/files/Addon%20-%20Music/5.0/SMC_Music_5.0_high_win32.exe/download"

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}