$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\JRT.exe"

try {

	Get-ChocolateyWebFile $packageName $fileFullPath $url

	Install-ChocolateyDesktopLink $fileFullPath

	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}