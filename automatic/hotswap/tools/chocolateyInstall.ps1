try {
	$packageName = '{{PackageName}}'
	$url = '{{DownloadUrl}}' 
    $unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
	$processor = Get-WmiObject Win32_Processor
	$is64bit = $processor.AddressWidth -eq 64
	
    Install-ChocolateyZipPackage $packageName $url $unzipLocation

	if ($is64bit) {
    & "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\64bit\HotSwap!.exe"
	} else {
    & "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\32bit\HotSwap!.exe"
	}
	
    Write-ChocolateySuccess $packageName
}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}