$packageName = 'classic-shell'
$fileType = 'exe'
$silentArgs = '/passive'
$referer = 'http://www.fosshub.com/Classic-Shell.html'
$partialUrl = 'http://app.fosshub.com/download/ClassicShellSetup_4_1_0.exe'
$downloadFile = "${packageName}Install.exe"

try {

  $downloadFileFullPath = "$env:TEMP\$downloadFile"

  $versionHtmlFile = "$env:TEMP\${packageName}-token.html"

  Write-Host 'Getting the needed token for the URL …'
  Get-ChocolateyWebFile 'get-url' $versionHtmlFile $referer

  $versionHtmlContent = Get-Content $versionHtmlFile -Encoding UTF8

  Remove-Item $versionHtmlFile


  # Get valid token from HTML to allow to download file
  $token = [regex]::Matches($versionHtmlContent, 'token = "([a-f\d]+)"') | % {$_.Groups[1].Value}

  $url = $($partialUrl + '/' + $token)

  cd $env:TEMP
  Start-Process 'wget' -ArgumentList "-O $downloadFile", "--referer $referer", $url -Wait -NoNewWindow
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $downloadFileFullPath
  Remove-Item $downloadFileFullPath

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
