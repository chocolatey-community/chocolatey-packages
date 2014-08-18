$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$fileType = 'msi'
$silentArgs = '/quiet'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\$packageName`Install.exe"

try {
  if (-not (Test-Path $filePath)) {
	New-Item -ItemType directory -Path $filePath
  }

  Get-ChocolateyWebFile $packageName $fileFullPath $url

  Start-Process "7za" -ArgumentList "x -o`"$filePath`" -y `"$fileFullPath`"" -Wait

  $packageName = 'appleapplicationsupport'
  $file = "$filePath\AppleApplicationSupport.msi"
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

  $packageName = '{{PackageName}}'
  $file = "$filePath\QuickTime.msi"
  Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
