$packageName = 'opera'
$fileType = 'exe'
$silentArgs = '/install /silent /launchopera 0 /quicklaunchshortcut 0 /setdefaultbrowser 0'
$url = '{{DownloadUrl}}'

try {
	$tempDir = "$env:TEMP\chocolatey\$packageName"
	if (!(Test-Path $tempDir)) {New-Item $tempDir -ItemType directory -Force}
	$fileFullPath = "$tempDir\${packageName}Install.exe"

	Get-ChocolateyWebFile $packageName $fileFullPath $url

	$extractDir = "$tempDir\${packageName}Install"

	Start-Process '7za' -ArgumentList "x -o`"$extractDir`" -y `"$fileFullPath`"" -Wait

	$file = "$extractDir\launcher.exe"

	Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

	Remove-Item $extractDir -Force -Recurse
}	catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}