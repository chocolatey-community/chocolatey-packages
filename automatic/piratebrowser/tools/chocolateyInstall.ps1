$packageName = '{{PackageName}}'
$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\PirateBrowser_0.6b.exe"
$url = '{{DownloadUrl}}'

try {
	
	Get-ChocolateyWebFile $packageName $fileFullPath $url
	
	7za x "$fileFullPath" -o"$installDir" -y
	
    $targetFilePath = "$installDir\PirateBrowser 0.6b\Start PirateBrowser.exe"
	
	Install-ChocolateyDesktopLink $targetFilePath

	Remove-Item "$fileFullPath"
	
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}