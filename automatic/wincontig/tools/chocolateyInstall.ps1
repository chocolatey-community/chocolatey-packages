$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
#$executable = " "
$targetFilePath = "$unzipLocation\$executable"
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64

try {
	
	Install-ChocolateyZipPackage $packageName $url $unzipLocation

	if ($is64bit) {
		$executable = "WinContig64.exe"
	} else {
		$executable = "WinContig.exe"
	}	
	
	Install-ChocolateyDesktopLink $targetFilePath

	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}