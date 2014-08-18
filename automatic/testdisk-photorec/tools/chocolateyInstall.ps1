try {
  $packageName = '{{PackageName}}'
  $url = '{{DownloadUrl}}'
  $unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

  Install-ChocolateyZipPackage $packageName $url $unzipLocation

  $targetFilePath = "$unzipLocation\testdisk-{{PackageVersion}}\testdisk_win.exe"
  Install-ChocolateyDesktopLink $targetFilePath

  $targetFilePath = "$unzipLocation\testdisk-{{PackageVersion}}\photorec_win.exe"
  Install-ChocolateyDesktopLink $targetFilePath

}   catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
