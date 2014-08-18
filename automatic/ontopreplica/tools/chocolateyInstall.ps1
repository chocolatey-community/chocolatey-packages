try {

	$packageName = '{{PackageName}}'
	$silentArgs = '/S'
	$url = '{{DownloadUrl}}'
	$fileFullPath = Join-Path $env:TEMP 'ontopreplicaInstall.exe'

	Get-ChocolateyWebFile $packageName $fileFullPath $url
	Start-Process $fileFullPath -ArgumentList $silentArgs -Wait
	Remove-Item $fileFullPath

	Write-ChocolateySuccess $packageName

} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw
}
