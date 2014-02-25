try {
    $packageName = '{{PackageName}}'
    $fileType = 'exe'
    $silentArgs = '/S'
    # {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
    $url = '{{DownloadUrlx64}}'

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

    $packageName = "secret-maryo-chronicles-addon-music"
    $url = "http://sourceforge.net/projects/smclone/files/Addon%20-%20Music/5.0/SMC_Music_5.0_high_win32.exe/download"

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

    Write-ChocolateySuccess $packageName
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}