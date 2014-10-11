try {

    $packageName = '{{PackageName}}'
    $version = '{{PackageVersion}}'
    $url = '{{DownloadUrl}}'
    $url64bit = $url
    $unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
    $mainFolder = "xpdfbin-win-$version"
    
    Install-ChocolateyZipPackage $packageName $url $unzipLocation $url64bit

    $osBitness = Get-ProcessorBits

    # Remove not needed folder with binaries
    if ($osBitness -eq 64) {
        Remove-Item -Recurse (Join-Path $unzipLocation (Join-Path $mainFolder 'bin32'))
    } else {
        Remove-Item -Recurse (Join-Path $unzipLocation (Join-Path $mainFolder 'bin64'))
    }


} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
