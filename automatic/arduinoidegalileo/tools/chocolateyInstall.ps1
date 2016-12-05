try {
	$packageName = '{{PackageName}}'
    $url = '{{DownloadUrl}}'
    $unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    Install-ChocolateyZipPackage $packageName $url $unzipLocation

    $targetFilePath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\arduino-1.5.3\arduino.exe"
    Install-ChocolateyDesktopLink $targetFilePath

    Write-ChocolateySuccess $packageName
}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
