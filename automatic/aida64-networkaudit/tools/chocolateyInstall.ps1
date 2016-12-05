$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$executable = "aida64.exe"
$targetFilePath = "$unzipLocation\$executable"

try {
	
	Install-ChocolateyZipPackage $packageName $url $unzipLocation

	Install-ChocolateyDesktopLink $targetFilePath
	
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}