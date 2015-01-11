try {
    $packageName = 'chromium'
    $url = 'https://download-chromium.appspot.com/dl/Win'
    $unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

    Install-ChocolateyZipPackage $packageName $url $unzipLocation

    $targetFilePath = "$unzipLocation\chrome-win32\chrome.exe"

    Install-ChocolateyDesktopLink $targetFilePath

    Write-ChocolateySuccess $packageName
}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
}