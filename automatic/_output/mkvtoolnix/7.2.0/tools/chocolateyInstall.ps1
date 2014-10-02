$packageName = 'mkvtoolnix'
$fileType = 'exe'
$silentArgs = '/S'
$url32 = 'http://www.fosshub.com/download/mkvtoolnix-7.2.0-setup.exe'
$url64 = 'http://www.fosshub.com/download/mkvtoolnix-amd64-7.2.0-setup.exe'
$referer = 'http://www.fosshub.com/MKVToolNix.html'
$downloadFile = 'mkvtoolnixInstall.exe'
$downloadFileFullPath = "$env:TEMP\$downloadFile"

try {

  if (Get-ProcessorBits -eq 64) {
    $url = $url64
  } else {
    $url = $url32
  }

  cd $env:TEMP
  Start-Process 'wget' -ArgumentList "-O $downloadFile", "--referer $referer", $url -Wait
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $downloadFileFullPath
  Remove-Item $downloadFileFullPath

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
