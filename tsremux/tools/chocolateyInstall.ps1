try {

    $packageName = '{{PackageName}}'
    $fileType = "exe"
    $silentArgs = "/VERYSILENT"
    $url = '{{DownloadUrl}}'
    $referer = "http://www.videohelp.com/tools/TsRemux"
    $file = "$env:TEMP\TsRemux0.23.2.exe"

    wget -P "$env:TEMP" --referer=$referer $url

    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
    Remove-Item $file
    Write-ChocolateySuccess $packageName

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}