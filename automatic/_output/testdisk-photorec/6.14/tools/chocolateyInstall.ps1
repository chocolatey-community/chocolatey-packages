try {
    $packageName = 'testdisk-photorec'
    $url = 'http://www.cgsecurity.org/testdisk-6.14.win.zip'
    $unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

    Install-ChocolateyZipPackage $packageName $url $unzipLocation

    $targetFilePath = "$unzipLocation\testdisk-6.14\testdisk_win.exe"
    Install-ChocolateyDesktopLink $targetFilePath

    $targetFilePath = "$unzipLocation\testdisk-6.14\photorec_win.exe"
    Install-ChocolateyDesktopLink $targetFilePath

}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}