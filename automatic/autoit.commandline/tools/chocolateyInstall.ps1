$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

try {
    Install-ChocolateyZipPackage $packageName $url $unzipLocation
} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
