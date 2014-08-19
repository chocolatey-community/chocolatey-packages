$packageName = '{{PackageName}}'
$installerType = 'exe'
$installArguments = '/passive'
$url = '{{DownloadUrl}}'
$referer = 'http://www.fosshub.com/Classic-Shell.html'
$fileName = 'classic-shellInstall.exe'

try {

  $fileFullPath = Join-Path $env:TEMP $fileName

  cd $env:TEMP
  Start-Process 'wget' -Wait -NoNewWindow -ArgumentList "-O $fileName", "--referer=$referer", $url

  Install-ChocolateyInstallPackage $packageName $installerType $installArguments $fileFullPath

  Remove-Item $fileFullPath

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
