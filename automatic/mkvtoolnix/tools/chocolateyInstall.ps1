$packageName = '{{PackageName}}'

$fileType = 'exe'
$silentArgs = '/S'
$partialUrls = {{DownloadUrlx64}}

$referer = 'http://www.fosshub.com/MKVToolNix.html'
$downloadFile = 'mkvtoolnixInstall.exe'
$downloadFileFullPath = "$env:TEMP\$downloadFile"

$versionHtmlFile = "$env:TEMP\mkvtoolnix-version.html"

Write-Host 'Getting the needed token for the URL …'
Get-ChocolateyWebFile 'get-url' $versionHtmlFile $referer

$versionHtmlContent = Get-Content $versionHtmlFile -Encoding UTF8

Remove-Item $versionHtmlFile


# Get valid token from HTML to allow to download file
$token = [regex]::Matches($versionHtmlContent, 'token = "([a-f\d]+)"') | % {$_.Groups[1].Value}

$url32 = $($partialUrls.url32 + '/' + $token)
$url64 = $($partialUrls.url64 + '/' + $token)

try {

  if (Get-ProcessorBits -eq 64) {
    $url = $url64
  } else {
    $url = $url32
  }

  cd $env:TEMP
  Start-Process 'wget' -ArgumentList "-O $downloadFile", "--referer $referer", $url -Wait -NoNewWindow
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $downloadFileFullPath
  Remove-Item $downloadFileFullPath

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
